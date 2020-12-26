<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use App\Entity\Example;
use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20201226180416 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE example ADD `state` INT');
        $this->addSql("UPDATE example SET `state`=".Example::SUBMITTED);
        $this->addSql('ALTER TABLE example MODIFY `state` INT NOT NULL');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE example DROP state');
    }
}
