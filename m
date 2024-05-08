Return-Path: <linux-kernel+bounces-173922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1138C0794
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 01:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6527C1F22DEE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 23:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219E053385;
	Wed,  8 May 2024 23:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="U5S6ym0Z";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Wz3b6OLW"
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27F357C80
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 23:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715210189; cv=fail; b=C0LkUsQWyCo8F4KEmydYCzlJlGvE/AvH1IJQDby0p/DrMJeBYUUVwB1lkLVDrE/INN1DQN94aRSF6385yyXAjmTu7UkSByI/lTH7+cM9zP/Fg2WMM77KKGY6IR7XB4hKQO0w76lm0ljxSwLQGyQxCE3aPhENnYirBjWoPSE8sPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715210189; c=relaxed/simple;
	bh=CV/mTTBNr8+nisO9nk3tjZB95za3nV+1m/Dpvbs/5nU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r+p8mlAiSWGoPQtCRIJBZAuUWYQfhGI45Zf1EnVNROhyAUj6oK1aY1C1664/FBhgxVTSPeR0fa2g0ET9+54nlsO0JMGxTImkGrTuYFp4MEpfzA6oT35x1pEStkcPI87lqUVWiWHM/JliwBrMg8yLmxZQrRajHd3/HI80cJfr1f4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=U5S6ym0Z; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Wz3b6OLW; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1715210187; x=1746746187;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CV/mTTBNr8+nisO9nk3tjZB95za3nV+1m/Dpvbs/5nU=;
  b=U5S6ym0ZpHxcCMQ1pxiTwhSkXxlfUE+2+9Engb2Az6D0dB2Gs9WR8NtP
   h1v3sRUl3PSIa/7vu277BTWOKaG3eGz8qGT1ixk0TElfB1QkbNgLUC+6e
   vlx3nY10Ghf40r1pKlWxlzvg5Hr3TrqHX46QEND8eRduEgH08f6o5yZAR
   3Na63LmJoQXxEt4+cfXGu9evXEMNZiwQv4JGhu7K4ll/1xBltyqL5t5pg
   jZZhJjBpczR0yErFYCmPrRmuXgw/AJk0jilyZ+mY2hJTGxsbo2D+Rg4wo
   qP21YJflM0pP9jY7Tb9v3exuAaxCduQdyDi75csM8y2Hn+xLqpMe7ZMtm
   Q==;
X-CSE-ConnectionGUID: iFKvlTJSRAGv5flN9pdegw==
X-CSE-MsgGUID: hc655gj0S2qWLVInmYfb1g==
X-IronPort-AV: E=Sophos;i="6.08,146,1712592000"; 
   d="scan'208";a="16146401"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 09 May 2024 07:16:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JirYw89QDpYaXIjamJO4O85F+ACFFbmvHMbStpBIOElunZ96lBpRwjsKhm/XVXxuWLVfO9i5V3P/D/0ubVM3v0Resi29wuJmzPNWxGWI+PKfO/I9H+AtykrbkB+Bmw1uy7RBqu5VPwu68a+FLJiHRet11EH/5KDbzuOc2l1vDb3szcwWtQrxVn1qC786y1x12vKxZNP9i1z+hzYoS0XfrzYjRlC2e3A7oaqpUMRlBReDxdQ+sBOI95EzBrjSHHCRBuoWweot11pi4u6q2Mh9vmuJO8C9rO2CcVAtoG8/vlXGDC6ro0rDf3pee3nJbnEFZg1m2mh8XobtZdBEt8t+Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CV/mTTBNr8+nisO9nk3tjZB95za3nV+1m/Dpvbs/5nU=;
 b=MCwyZQESnANl/1UjwIuinf2QYwe3fK7EoRmGjvUsYJVHWV434V93SulfI/JDP+L6kuyLBN/eynp8UWkp1UUSnyvTfoOpjMJibWKE4jZHvC5v4uCOxbYEI5F3BwwgI+TI0VDhfMHLLJ29wXN3Cv+R3BVZX4So2sbQ9zgAtEE6KbPstsAsdFlJ2uwBJxCgbvC8qNv0YHQSbLNQnkaZt2Yff1NyOr6FHJNfk1xAVG8BQNNOc3i85JuuhTD01o95slANA+LfiDLjxUOKrGOdKPfMGvM/Bcb3afVFNlDLqRMd4xRaHVJCYbfzj6NL+ntKLu38XLRJx3kcA/IkLEVmIV2uoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CV/mTTBNr8+nisO9nk3tjZB95za3nV+1m/Dpvbs/5nU=;
 b=Wz3b6OLWx0WhCDjAElgWWyIsRr04li8A0HcYKZLsQV0/A/UfbYlbvhroBrmFzQaXlVAh4MEpX363/i/21ZZ1OaFaxQlPK0/txQXX2LPOpfLAUrYkQmS6MxAS9Jfl9GAJccCA34pYDJKHyZDFh/J0BwNDyPGDrOEiQsBQGtiskrA=
Received: from BYAPR04MB4151.namprd04.prod.outlook.com (2603:10b6:a02:ef::28)
 by BN8PR04MB6306.namprd04.prod.outlook.com (2603:10b6:408:d6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Wed, 8 May
 2024 23:16:21 +0000
Received: from BYAPR04MB4151.namprd04.prod.outlook.com
 ([fe80::202c:5b59:1db1:25f1]) by BYAPR04MB4151.namprd04.prod.outlook.com
 ([fe80::202c:5b59:1db1:25f1%4]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 23:16:21 +0000
From: Kamaljit Singh <Kamaljit.Singh1@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: WQ_UNBOUND workqueue warnings from multiple drivers
Thread-Topic: WQ_UNBOUND workqueue warnings from multiple drivers
Thread-Index: AQHaeXhd/UIUk2VZGEG0Qh+3CF4eQLFAWi8AgAIfawCAEyxD94AHteGAgDDsFIo=
Date: Wed, 8 May 2024 23:16:21 +0000
Message-ID:
 <BYAPR04MB415180536421C9B8326D6A30BCE52@BYAPR04MB4151.namprd04.prod.outlook.com>
References:
 <BYAPR04MB41513F04DB2ECDC3601CC36ABC2D2@BYAPR04MB4151.namprd04.prod.outlook.com>
 <c4057654-97bd-4721-9bed-9dd5ef8b3f8d@grimberg.me>
 <6d3af8dd-30c3-48d4-9083-7f00ea21ff8c@nvidia.com>
 <BYAPR04MB415196EC84756BA1876463DABC3E2@BYAPR04MB4151.namprd04.prod.outlook.com>
 <f5d57e3b-8168-41af-8e36-c7a21ef3a475@grimberg.me>
In-Reply-To: <f5d57e3b-8168-41af-8e36-c7a21ef3a475@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR04MB4151:EE_|BN8PR04MB6306:EE_
x-ms-office365-filtering-correlation-id: c529ae97-6cae-4b1d-3910-08dc6fb4df8c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?R2kk3qnKN0JsbDtK1xwbezwNaK3DZ0d+5kxw9tZQLAlBmuqGMmFBgH+I?=
 =?Windows-1252?Q?5LBIrzu1jfzamwo1BoyVIEibaa/OlYdzcvOlG/DP0/AcCDYdmD+Sam/Y?=
 =?Windows-1252?Q?sD1irU33vZAVaZUX7Fb3cGNxSSKO9XAbCHPn0MwFlLCAqAWJ73sRusWQ?=
 =?Windows-1252?Q?bBONy/uPThyczEiej+baQ/nw6ozwGSF0g0BSe0dDmnxfHwXPATyusITR?=
 =?Windows-1252?Q?9tn6l+93wtqoGxQoUYvKwNIVALBsxaoAHQSWIjvFzmfEMrh2h1uRKQVR?=
 =?Windows-1252?Q?Mxe1StGmA1BxPFFRWkD5hWIzdYX+HNjC4pvlHOFUFQMaCzJCkM806rAU?=
 =?Windows-1252?Q?0JCzplWD4lpFpmCngUdFwtl75ZyhxBnj73PIfRZ1jaI1IkiSpgFh2eEj?=
 =?Windows-1252?Q?haV0ke1Rqr00z0OnsptsZGGOvQGwm4r8uXoHX82GpGTwjk6KUtYLnMf/?=
 =?Windows-1252?Q?pj5EiVPukynBkvScupNU4C5fP5TXj75+lAdC7jG3k5sMs/s3zcmMq6MT?=
 =?Windows-1252?Q?P9LzvPrgo8ow7JFdVM62WEGHGgqMrwWIyFWszZEC7vkwitMQA3UdBMBr?=
 =?Windows-1252?Q?JKU++hBYSC8LnLNdIK4YRNMJCJZ3beU/Yg3MuVmxpP/XJkBpuhPdtUQq?=
 =?Windows-1252?Q?32qTNZZD1mxApWmO9xITll0JemBPcX4h+fmR+3kS6/iB99ibPyAEpFUQ?=
 =?Windows-1252?Q?ACt5UA7JC3C7vvfctaMW/a/nPtEPSvWmX3NumPwAaJdZHnwVpjM97or0?=
 =?Windows-1252?Q?irLv52IfLKKSpLiGB/Ga6PCgh4htlV+lZYQzbERet5kPgDi+gJmg8OzW?=
 =?Windows-1252?Q?ZgoIpWNKPNWo0qmUZKi24DYNpRkkWZjN0a0kv0J5wpjdBhRAWGrsGhp1?=
 =?Windows-1252?Q?t4X0ZB2lMgHMroW54L9+izAVFxhK/IuA9hqetlaAynaay8JnQXqtu3yb?=
 =?Windows-1252?Q?4WXmqYCUhOvHwVwtEfy2gZatl3Cr7oJEoOag5lzdmYPsWTLVd9ZJebzv?=
 =?Windows-1252?Q?iAUSe88vio1zZArsSXW0G4A2BVP7gzSsS1y59kiRoWtEOUGtSYdJyKDK?=
 =?Windows-1252?Q?ouyKas/QsephRw0RcGs9WftpT2nIx+qDfYL98/R8iWBHxrNs8ZQyvyLc?=
 =?Windows-1252?Q?wVCq5UtMNAOsQWun5fro2uZC7Io8RWD90Xyw2cErhKf3RVO3DJUVIifY?=
 =?Windows-1252?Q?mGsdLNTv/+xkZS44LAvK+cGd6yuhrEfregl6wvWr+ynId19ICyZ9pUkX?=
 =?Windows-1252?Q?bH4s0818CSSXOmTDgjxZX5Qw/aLBk+wpk71yqFjVgv1CqkmWY7U9N0DG?=
 =?Windows-1252?Q?7kofxMYRrGKqUugx5P4qgSH6yBE71+BTSyQ4jb7UbATenq/2ziW6FYcv?=
 =?Windows-1252?Q?D7pJ3tH35iQDUYjhYc0eXXrAYvf3vHKl+pOpLK5FgEcDc/Nc82jfVGJi?=
 =?Windows-1252?Q?M7tpRazj22siDPIzX3uP7w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4151.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?7xS/sl6e4+76HlUau16+vAXBHQHM1BRVW1JB42IAGzF8SeTtgDSqp0LM?=
 =?Windows-1252?Q?2AaU2VIwpAZdIVfkPWep4yqRIhw8vIVHTRC0lELXp2+8OzOzA293JKW+?=
 =?Windows-1252?Q?0RzCpkACNQVb+MOHgTs//NCuLCMKsJUFjGiiEU9Xow68qFKUHl2yVH1j?=
 =?Windows-1252?Q?9gn4ifLA9pmypKYD2lWFPXzT7rTVXo/Pp48PcyV6s3z45DdvPJsV9PnJ?=
 =?Windows-1252?Q?ETf0pEDXob92y4092FzMDe/3xZ0f+FJnxwO1/Bj3QvfMAoKsGPFdAN5H?=
 =?Windows-1252?Q?Ah9JgnV/GODGcZ3AAGwsENEoqhmTpRi6yp2LyFlnwa+Wrz8Z2Mcj0UT+?=
 =?Windows-1252?Q?JeI1MhFDXM6xrCiHvRD5P1KQ+n8fpHuh6iUMRhfgx7dgspmHUw5nP4rx?=
 =?Windows-1252?Q?K0ZjNNgScy3wiUoWO5io/8FcZbjVz97/hrMLakW6+fJnsHgw/Lh35f7Z?=
 =?Windows-1252?Q?hVccYeJyY6XMoI50RWz+wYiK+Ejf0aWOM/FM6qEvksoQY0uUcuaatj2Z?=
 =?Windows-1252?Q?MNUPaqjWBCG53IbXpLz4EaqcNJQH7uRm6P/STbj1n3sAjU1iiFQCNnu/?=
 =?Windows-1252?Q?n5ZIdo9f19WNodkBsAEB1MYpkvcb7dWB8AUVkS4hhYnybswQ7RsZYQf2?=
 =?Windows-1252?Q?cSpgkKkPzHF4VuCUetX08/V/GlqIst+G2n1c5ODC5+dj0Fx3a2wB6Ij+?=
 =?Windows-1252?Q?p4IZwvCcPD5zuCguB3hkH2AFt381qA8asRi0T2f28vCAtxoVczRa7zXF?=
 =?Windows-1252?Q?u6sECatyM8FqZ/nw1FT1F4qApa1Kj9g/ajPaqJzb1WWEBfms5C9Ppial?=
 =?Windows-1252?Q?dd2VA5F2d3RBRJ9PLcNTvM3qV8xDYSnldnPMdZg/ao7GxeV/9HCDcIi3?=
 =?Windows-1252?Q?HNxOtp28yaR71Wfki9ROWx2U3MHWpJ/tn/uQVDktyKkvKktLa/ijyvh0?=
 =?Windows-1252?Q?9MJ8p9BNcgPa39yLKL/0OnDMUbDq9XETn0iy/nO2RFBH9uemFTFW8Ich?=
 =?Windows-1252?Q?GZ602aM7AwV/mt7HQ1kjpSF9XBO9OLLjkZWmvaSQGbyH62520B1RHRip?=
 =?Windows-1252?Q?L9pzbsmySOqSNtI9ZzI+mdj1sYJn4UaOybo4VSrdO2t7ma0s2PHKTYp8?=
 =?Windows-1252?Q?4RmKre7j/K/jBsXCewO6+YYeFOi43usyWZJN3WCx5B96iINqV5YPgM3v?=
 =?Windows-1252?Q?qXyKPWuQiEb891vNFLYdDcaLvfiNZZ5265/xCoqmQwzgrl+yVWyemrmT?=
 =?Windows-1252?Q?knlDFtQzhSUNUm/E1Rs1nqHgPch9KudgJfugqHxvJ42Yqj+avOpb+Znf?=
 =?Windows-1252?Q?6kCTPTOB6K1ZdgMmEZWao/BbXUJJQJ7I7UGnxxgZiiWjDBx6LawsIjgQ?=
 =?Windows-1252?Q?JZe/9mgv+f2Jgh5JQe9oho/vevMfbAAgroB3EueYS5wcjUPL4ILwCKG1?=
 =?Windows-1252?Q?PlV1QyJdoxCAMQuN5ODCcjwBvC/YkNgU0ecS+kLkIhdQ+kOM5SWSK5oI?=
 =?Windows-1252?Q?eYVagNfQPl6ftE5cWcX8utlFlqx4O1sUBFzLkt4EAhxY1QL9QXBiLXyQ?=
 =?Windows-1252?Q?3GNZjX0kRLZsA9fAM30b39v4BA+YSpQ8v98ka44A7BYMxM2Y2wuYkxkx?=
 =?Windows-1252?Q?Fz0U7M9kow/Rkc+irnXW3jtVLwVfMC3jWNaIXTMktQErCWNtCYaAn+bj?=
 =?Windows-1252?Q?ZAb9PauwgAZR1HfW5GxOeTv2O1/LRCYa?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	d5XISodmaCp57pmzZoGOa2jpHJsdACeQr+xGj8cZEygMeZWmA2MN0EJezYVNAHFHMUczuy9GWt8G2fmDP81fc/+LUKYZblhGDINbV5cx5ZzQ6WYCa9k2tc6P+CJae2yS6msi0gNvegxKeWBdYiCpD6EO+EHnMZIV9D0pNZ98cqEE6/Wh5AQFR41ufowOYfR0z+clh3o71o4KAZHdsfAHQwFMXO7BQVPRCsG42KU/hEYFn+ZCqJXg9t5LMiUz2aeaRaSg8OsH5eJerqTUBtEGmQYQNmWQehvWiUoCX3QbnBBkX07w3/SrDw2nJiZw13wbRxR2/QupiTtJKrVKtZc62B7RH2ZBeyXHuR4mRa0KByCwKdonK6VyZD3kpC3Y30aMq7vEjKpHfuX1h0c1qHHyspDPgOOxbEpppVUkrx4sr8/DLbIDvhEAhLzWJ4Bd7BPgHpHHxKRBzoI8x/6Qz++y3v7D6m1UEE5yBU+hB24vgprH1t2NHV6pUit1RtfDnwoVLR0wm+noMgadC+ySDhkBMF5IxebT8NY7cFbvHXrL0X+ifS6gwtCnTzAfl87H0fEWpFNzUCuzCGlQwus3O/z8XipY9ei/cN0bzJYeNZs2zqNrMTsgcpJh4iZWllKUqmjb
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4151.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c529ae97-6cae-4b1d-3910-08dc6fb4df8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 23:16:21.4865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r9ijayJZ1YA2lUBT8H1BovkR8M1WMmON2AMzyOCIWv6JFS08KDk15F7jTceI9XkdsLReiLWeOW5qD7hOc5AYtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6306

Sagi,=0A=
=0A=
>Does this happen with a 90-%100% read workload?=0A=
Yes, we=92ve now seen it with 100% reads as well. Here=92s the Medusa cmd=
=A0we used. I=92ve removed the devices for brevity.=0A=
sudo=A0/opt/medusa_labs/test_tools/bin/maim 20g -b8K -Q128 -Y1 -M30 --full-=
device -B3 -r -d900000 <device_list>=0A=
=A0=0A=
We saw the original issue with the upstream kernel v6.6.21. But now we=92re=
 also seeing it with Ubuntu 24.04 (kernel 6.8.0-31-generic), where IOs are =
timing out and forcing connection drops.=0A=
=A0=0A=
=A0=0A=
>Question, are you working with a Linux controller?=0A=
No, with our ASIC (NVMe Fabrics bridge).=0A=
=A0=0A=
>what is the ctrl ioccsz?=0A=
ioccsz=A0=A0=A0 : 4=0A=
=A0=0A=
=A0=0A=
Thanks,=0A=
Kamaljit=0A=
=A0=0A=
From: Sagi Grimberg <sagi@grimberg.me>=0A=
Date: Sunday, April 7, 2024 at 13:08=0A=
To: Kamaljit Singh <Kamaljit.Singh1@wdc.com>, Chaitanya Kulkarni <chaitanya=
k@nvidia.com>=0A=
Cc: kbusch@kernel.org <kbusch@kernel.org>, linux-kernel@vger.kernel.org <li=
nux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org <linux-nvme@lis=
ts.infradead.org>=0A=
Subject: Re: WQ_UNBOUND workqueue warnings from multiple drivers=0A=
CAUTION: This email originated from outside of Western Digital. Do not clic=
k on links or open attachments unless you recognize the sender and know tha=
t the content is safe.=0A=
=0A=
=0A=
On 03/04/2024 2:50, Kamaljit Singh wrote:=0A=
> Sagi, Chaitanya,=0A=
>=0A=
> Sorry for the delay, found your replies in the junk folder :(=0A=
>=0A=
>>=A0=A0 Was the test you were running read-heavy?=0A=
> No, most of the failing fio tests were doing heavy writes. All were with =
8 Controllers and 32 NS each. io-specs are below.=0A=
>=0A=
> [1] bs=3D16k, iodepth=3D16, rwmixread=3D0, numjobs=3D16=0A=
> Failed in ~1 min=0A=
>=0A=
> Some others were:=0A=
> [2] bs=3D8k, iodepth=3D16, rwmixread=3D5, numjobs=3D16=0A=
> [3] bs=3D8k, iodepth=3D16, rwmixread=3D50, numjobs=3D16=0A=
=0A=
Interesting, that is the opposite of what I would suspect (I thought that=
=0A=
the workload would be read-only or read-mostly).=0A=
=0A=
Does this happen with a 90-%100% read workload?=0A=
=0A=
If we look at nvme_tcp_io_work() it is essentially looping=0A=
doing send() and recv() and every iteration checks if a 1ms=0A=
deadline elapsed. The fact that it happens on a 100% write=0A=
workload leads me to conclude that the only way this can=0A=
happen if sending a single 16K request to a controller on its=0A=
own takes more than 10ms, which is unexpected...=0A=
=0A=
Question, are you working with a Linux controller? what=0A=
is the ctrl ioccsz?=

