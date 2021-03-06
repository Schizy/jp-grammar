<?php

namespace App\Entity;

use App\Repository\KanjiRepository;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=KanjiRepository::class)
 */
class Kanji
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=1)
     */
    private $kanji;

    /**
     * @ORM\Column(type="boolean")
     */
    private $isJoyo;

    /**
     * @ORM\Column(type="smallint", nullable=true)
     */
    private $commonStat;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getKanji(): ?string
    {
        return $this->kanji;
    }

    public function setKanji(string $kanji): self
    {
        $this->kanji = $kanji;

        return $this;
    }

    public function getIsJoyo(): ?bool
    {
        return $this->isJoyo;
    }

    public function setIsJoyo(bool $isJoyo): self
    {
        $this->isJoyo = $isJoyo;

        return $this;
    }

    public function getCommonStat(): ?int
    {
        return $this->commonStat;
    }

    public function setCommonStat(?int $commonStat): self
    {
        $this->commonStat = $commonStat;

        return $this;
    }
}
