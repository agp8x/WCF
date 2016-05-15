<?php
namespace wcf\data\spider;
use wcf\data\DatabaseObject;

/**
 * Represents a spider.
 * 
 * @author	Alexander Ebert
 * @copyright	2001-2015 WoltLab GmbH
 * @license	GNU Lesser General Public License <http://opensource.org/licenses/lgpl-license.php>
 * @package	com.woltlab.wcf
 * @subpackage	data.spider
 * @category	Community Framework
 *
 * @property-read	integer		$spiderID		unique id of the spider
 * @property-read	string		$spiderIdentifier	unique textual identifier of the spider
 * @property-read	string		$spiderName		name of the spider
 * @property-read	string		$spiderURL		link to the spider's website or empty if no such website exists
 */
class Spider extends DatabaseObject {
	/**
	 * @see	\wcf\data\DatabaseObject::$databaseTableName
	 */
	protected static $databaseTableName = 'spider';
	
	/**
	 * @see	\wcf\data\DatabaseObject::$databaseTableIndexName
	 */
	protected static $databaseTableIndexName = 'spiderID';
}
