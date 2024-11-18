Return-Path: <linux-kernel+bounces-412994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 298F69D121B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F32C2B28F82
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E591B6D11;
	Mon, 18 Nov 2024 13:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="KtiIk4Ro"
Received: from alln-iport-3.cisco.com (alln-iport-3.cisco.com [173.37.142.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040D419E993
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 13:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.142.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731936789; cv=fail; b=AilT+dpYvqBGz7SK3MP1KQ0RgPa6h9PTZTFrEXKuEzynoi6yINiqdLah9ewdNfVIa9Ygz4RzJBnzmfivzu+OK3fwuPUNQ+nulh21OMbha5SJNiVZjyteMykvEM92SnhEA33gYXJK4wthOxBXTURT/RE4TqjFTEeduFwNne9aqtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731936789; c=relaxed/simple;
	bh=Kyf7j2IALe+8WQV6jfPuv3sZDs0i5kfitFB0hMxPOMY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T0pDLFiuCkEm3UN5a95KDU4hyONRMH85QzzqAKneKFtUQC4fKSuMRrleo+HO860esR++6vT7LwhlTzDB5dpvStQpQkxlDk41q6ixL/5tr6ll/65WElHp4CndcKQZ5LUF3iWZPoIilj26yznlDvH70iC4680t1oYCa+27GuW71X0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=KtiIk4Ro; arc=fail smtp.client-ip=173.37.142.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=3876; q=dns/txt; s=iport;
  t=1731936787; x=1733146387;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Kyf7j2IALe+8WQV6jfPuv3sZDs0i5kfitFB0hMxPOMY=;
  b=KtiIk4Ro6LLG0VJB4W1osnvydf/3vrwp56xN2+g5pelo4vKi5Fq8Zmyc
   dMUpPGwrv9bf5l+eoVjQ1EowqrQooIFkYR/d9zhEb6XYobOqkpMAd2TxF
   5NGSFvJVgHD1gm+7E4YNvWMBUV3MZxQDiKZ/jjGuS5u+Ne+e9iDYQbbu3
   s=;
X-CSE-ConnectionGUID: WoNpevZUQn2nYZU83ULDeA==
X-CSE-MsgGUID: 8cHU4vl8TN+xQlNr12yQTg==
X-IPAS-Result: =?us-ascii?q?A0AFAADPQTtn/5D/Ja1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQCWBGgUBAQEBCwGBcVIHghKFHYNMA4ROX4ZRggQdA4V6jHGLL?=
 =?us-ascii?q?IF+DwEBAQ0CRAQBAYITgnQCFoo0AiY0CQ4BAgQBAQEBAwIDAQEBAQEBAQEBA?=
 =?us-ascii?q?QELAQEFAQEBAgEHBYEOE4YIhlsBAQEDEhERRRACAQgOCgICJgICAg4hFRACB?=
 =?us-ascii?q?A4nhUQDAaQtAYFAAooreoEygQHgIBiBAi4BiEsBgWyDfYR3JxuBSUSBFYMqP?=
 =?us-ascii?q?oRag0SCaQSCQYUPJYh/iWsLkBUJSXscA1khEQFLCjUMOCtGISwDgkeCNYFSg?=
 =?us-ascii?q?kaBFIMugV4FNwqDCYE0NwINAoJFcx+HZoELg2GDRYEZgW2CFx1AA3g9NRQbB?=
 =?us-ascii?q?j2kCRg0gWdFG4EVkl4RPYJkAUmPYZ9MCoQaoiOqOy6HW5Buo0uFMgIEAgQFA?=
 =?us-ascii?q?g8BAQaBZzyBWXAVO4JoURkPVo1UGcl9gTMCBwsBAQMJkGIBAQ?=
IronPort-PHdr: A9a23:YK7J5BcZXqr+FZtilgcCLbMAlGM/gIqcDmcuAtIPkblCdOGk55v9e
 RGZ7vR2h1iPVoLeuLpIiOvT5rjpQndIoY2Av3YLbIFWWlcbhN8XkQ0tDI/NCUDyIPPwKS1vN
 M9DT1RiuXq8NCBo
IronPort-Data: A9a23:Oh9rD6n+Plg+CeouiJYrcEPo5gzWJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xJKXGCGaavcZWfyLYhyb4Tl9xgO6JeBndAxSAFrryhnF1tH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaC4E/rav658CEUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dha++2k
 Y20+pe31GONgWYubjtNsvLb8nuDgdyr0N8mlg1mDRx0lAe2e0k9VPo3Oay3Jn3kdYhYdsbSb
 /rD1ryw4lTC9B4rDN6/+p6jGqHdauePVeQmoiM+t5mK2nCulARrukoIHKZ0hXNsttm8t4sZJ
 OOhGnCHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqHLWyOE/hlgMK05FbIf3P56H1Nzz
 PpCLgE/U0DYusaazZvuH4GAhux7RCXqFJkUtnclyXTSCuwrBMicBa7L/tRfmjw3g6iiH96HO
 JFfMmUpNkmdJUQTZj/7C7pm9AusrnX2dTxVrE2cjaE2+GPUigd21dABNfKOK4HTFZQMxhvwS
 mTur2/ZP00EMIyj73mVy3aKnLaVjBrHV9dHfFG/3rsw6LGJ/UQXCRsLRR64rOO/h0qWRd1SM
 QoX9zAooKx081akJuQRRDWiq3KC+xpZUN1KHqhit0eGy7Hf5ECSAW1soiN9VeHKffQeHFQC/
 lSIhNjuQzdotdWopbi1r994cRva1fApEFI/
IronPort-HdrOrdr: A9a23:i5oqC69n9V5ZqJRP8Utuk+Gkdr1zdoMgy1knxilNoENuA6+lfp
 GV/MjziyWUtN9IYgBfpTnhAsW9qXO1z+8S3WGIVY3SEjUOy1HYXb2KirGSggEIeheOudK1up
 0QCZSWZOeAaWSSyPyKnzVQcOxQgOVvkprY+Ns2pk0FJWoFGsMQijuRSDzrbnGeLzM2fKbRYa
 Dsnfav0ADQAUj/AP7LYUXtdtKz1OHjpdbNWzJDLRgh7wWFkDOv75DHMzXw5H0jegIK640PtU
 zenSLExojLiZyGIxnnuFP73tBzop/M29FDDMuDhow+MTP3kDulY4xnRvmroC01iPvH0idprP
 D85zMbe+hj4XLYeW+45TH33RP77Too43j+jXeFnHrYp9DjTj5SMbsFuWsZSGqc16MThqA77E
 t55RPBi3ORN2KZoM3J3amOa/itrDvunZNtq59Is5UVa/pvVFYYl/1swKoSKuZCIMo/g7pXTN
 WHy6rnlatrWELfYHbDsmZ1xtuwGnw1AxedW0AH/teYyj5MgRlCvgElLeEk7z89HagGOtJ5zv
 WBNr4tmKBFT8cQY644DOAdQdGvAmiIRR7XKmqdLVnuCalCYhv22tLKyaRw4PvvdI0DzZM0lp
 iEWFREtXQqc0arDcGVxpVE/h3EXW34VzXwzcNV4YR/p9THNffWGDzGTEprn9qrov0ZDMGeU/
 GvOIhOC/umNmfqEZYh5Xy2Z3CTEwhpbCQ4gKdNZ7vVmLO/FmTDjJ2uTMru
X-Talos-CUID: 9a23:erwprGD58DB5cS/6ExZg0lYZBPIYS3uHykbiHh/jNEJFRZTAHA==
X-Talos-MUID: 9a23:xF/HFwYH88Rk9eBT5zTMuW18MJdUxee+MUQri8xcqvC4Onkl
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-l-core-07.cisco.com ([173.37.255.144])
  by alln-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 18 Nov 2024 13:32:59 +0000
Received: from rcdn-opgw-5.cisco.com (rcdn-opgw-5.cisco.com [72.163.7.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-07.cisco.com (Postfix) with ESMTPS id 7F7D51800022C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 13:32:59 +0000 (GMT)
X-CSE-ConnectionGUID: /428dn3TSQeaA0/dZwVlig==
X-CSE-MsgGUID: 8gd5cTS2TbCQl828pkBP6Q==
Authentication-Results: rcdn-opgw-5.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.12,164,1728950400"; 
   d="scan'208";a="19518271"
Received: from mail-mw2nam10lp2048.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.48])
  by rcdn-opgw-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 18 Nov 2024 13:32:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RtTTwSAE6dg0taU1f8svm9Fd790XEXsLmjuWm3GSxgwrl50NK8TLnzJ3EWiXK3w4g9j5oVWXxYu8Lf2gQmTdpkUR2gp8CamwzAiZPF2kU8mq/qaE0e5xQicG9smkIDigxLwVI1G4OVHIhMSBxY/1JmfiVzO4+YSZ4MUfWmVRHKz1WxfIXNtLpKRgwcxzoHBJTYUiXcur48uIex1MWyS/OxlI8W+Jp/ijTlaPP2hByO9Vanfnynbn5IxXqKYs2hsFIlPWy50P8ltS+KMmkg23g3urrWCioYqpuTV4DVyWwjlX5jtg0q06uwfdJqT3X8BdtlyVd30iGx5hWqf8ZUpfvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kyf7j2IALe+8WQV6jfPuv3sZDs0i5kfitFB0hMxPOMY=;
 b=vt26PSJczSjXCFYhNnPQmhrqaJSZZy9vfwehcFYGsmq596WrwdhdGVM0ec7W5gcAcBQXb/gf6zFFjxW2lOhEvkAKOgZbaVDyHDIcu8bGJwQ46yBLMCse2oIFaNXu9ZCN4r70EFrUS1O5hw/9ZpgQYfwMB9wyNqajR31huv237Q9kx99F3mkzzy617nCJJJcEDd44WBoGa6YlAHO4yScW9xildsgzjwP05P9HUFNCysJM/wOLXh7l+PnvwQkXlyuakJjdM7hCea/w645ViPilrAbMYf/JdbWZwrS9mVt+Tmy+bJIfl6hsu3kbjX4iJ9w/Cy1rxqDL2FivR7pYkVYkxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from CH3PR11MB8775.namprd11.prod.outlook.com (2603:10b6:610:1c7::5)
 by DM4PR11MB6310.namprd11.prod.outlook.com (2603:10b6:8:a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 13:32:56 +0000
Received: from CH3PR11MB8775.namprd11.prod.outlook.com
 ([fe80::d17a:fdd6:dfc9:19da]) by CH3PR11MB8775.namprd11.prod.outlook.com
 ([fe80::d17a:fdd6:dfc9:19da%4]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 13:32:55 +0000
From: "Daniel Walker (danielwa)" <danielwa@cisco.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Hans de Goede
	<hdegoede@redhat.com>, =?utf-8?B?SWxwbyBK77+9cnZpbmVu?=
	<ilpo.jarvinen@linux.intel.com>, Klara Modin <klarasmodin@gmail.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Danil Rybakov
	<danilrybakov249@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "xe-linux-external(mailer list)"
	<xe-linux-external@cisco.com>
Subject: Re: platform/x86: p2sb: Allow p2sb_bar() calls during PCI device
 probe
Thread-Topic: platform/x86: p2sb: Allow p2sb_bar() calls during PCI device
 probe
Thread-Index: AQHbNeKxizzLej0qw02u6pHMIY1jfA==
Date: Mon, 18 Nov 2024 13:32:55 +0000
Message-ID: <ZztCB5hN2NBnPgiR@goliath>
References: <cd1cedcc-c9b8-4f3c-ac83-4b0c0ba52a82@redhat.com>
 <82ab3d06-40e6-41dd-bb43-9179d4497313@redhat.com>
 <2c828592-dbdd-4cd4-b366-70797d63329d@redhat.com> <ZzTk5kyPa5kUxA+f@goliath>
 <a5bafe87-e8f6-40d9-a5d8-34cf6aa576a4@redhat.com>
 <wxb4hmju5jknxr2bclxlu5gujgmb3vvqwub7jrt4wofllqp7li@pdvthto4jf47>
 <ZzdhTsuRNk1YWg8p@goliath>
 <5qjbimedzeertdham2smgktt54gzdc7yg4dwgiz7eezt2tf5a2@szhhpvzo3uhj>
 <Zzs1rw1YcoEEeW7+@goliath> <ZztABO3TyJBekZRs@smile.fi.intel.com>
In-Reply-To: <ZztABO3TyJBekZRs@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8775:EE_|DM4PR11MB6310:EE_
x-ms-office365-filtering-correlation-id: 20f35c03-fa29-4a8e-a917-08dd07d582a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SXVhbGxOZmVxV1FnMHlsck5IRXJxbVRSSVJVaWUydFgxL1IvWmVmZzJwMDR3?=
 =?utf-8?B?WTBzV0VJMExjRmxZa3JiL3l6TVRwVVZ2a2JBQ3JvRVRBL3ZMVGJQVXVUSFFI?=
 =?utf-8?B?ajVoUnhueCtIZ3N6Zk9ub0g4QXdIUTcydmJhN0c1Tjh6TTBwaXk5YVYvOUNm?=
 =?utf-8?B?clFYWTltLzNaOTA3bS9RZEs2dlZDcGNFbUZaWmxIREx2b054UTZ2V1dvRlpa?=
 =?utf-8?B?Ukpwc0dBTFliT1dLb3pnK3RGQzRhakpkVHBBWlM0SWJwUWZpNEdiclowMG8v?=
 =?utf-8?B?VGJ0aVFmZndUSEtBOGY3eUdIdDZTai9tS25NaVdMMFRSRmY3dkdYNDJ4b0ZE?=
 =?utf-8?B?SlU0MEZ4NFA1eC9MSWJYdHgvY1lHOVora1BtdDdJdDhtN1dnSjBoZzFvZjdu?=
 =?utf-8?B?Ni82ZFl1Y095dFhMbEVSNUh6eFFRM0h6ejRPY0xSeEtYcXNoajZLRnJBSSt1?=
 =?utf-8?B?SjZYSGFveWhhUDdWVUN6RklCV3VMalExbFRJV1RTdW4rMll1b0dTelliQkx0?=
 =?utf-8?B?clgzZ1pBZ2k2YjBvaVZmZ3JRRUUrQzQ2Zy9UcGJtaTBTanJzRUZvYjFKKzg5?=
 =?utf-8?B?T2QxQlpDOFZJOFZBUTA1eVFGT01SOWFtOVNlZnhIMHh3SnVoV3k0RDArRGJB?=
 =?utf-8?B?YVNFRGlhS0R6aWxzbkVEbG5YZWJYaWlrTzVLeFRHSkZDK2JIUEtjOVdaOFA5?=
 =?utf-8?B?T1JGcU5SY3FGblBOeUJLQlJabnNzZGNrOXlXem5ucWJMeThVNG5oZ21tc3hq?=
 =?utf-8?B?U2gyeFN2M1hWS3NNQ01ZVnZrWEhINCtxUHY2UER2QkM4M3NDOFcrVmpRQU5o?=
 =?utf-8?B?R3Q5cTRYRVB2WDRRRmh1a3lLbllmVFFoYU10aGhmV0dzcGt0aUYzeTFScjR4?=
 =?utf-8?B?M3BxZHJIWDhiUTNFenVRYmI5L0pmbzZubFRuYnBjT09qenQyR3kzc2tET2ls?=
 =?utf-8?B?ak5QZ1JBeDBTSmozVEVKdlFFbUxIaDdXcjB4Tm1id241UGlYd1Q0cmh2UEVU?=
 =?utf-8?B?Z3VzdXB3MWVjQlppTHoxSjZoVWhSTEdvN1ZoaWVhQUlZb1Y1QVo0NjB5SWVD?=
 =?utf-8?B?R2JLUWM1SlhWS0xTUERKM0IxWEEvUnR2UnJhN0FTWE1UdWZOVjNFQXUyYWVz?=
 =?utf-8?B?bTF6aHpUV2lPMW13RkhQczY2dXp6QXpXMFlGeGpPQVZ4YjhFQWFaQXk0S2Z5?=
 =?utf-8?B?MUYzcmhBbWxtbWEraG1CVWpQVzdoRURiMy9BbHVkMmdBaDFtZS9HcStwL0pQ?=
 =?utf-8?B?UGxhbUF4bkcwa3RoVks3aGtiandhODJtZWJSUi8wTE5NV3BLQVJrWWhTT1hL?=
 =?utf-8?B?b2UzV3RGdm1FeTNhNStOK2dRQVZSZ2lycFpucm9aRDRSOWI5bWl0UGJpWDlR?=
 =?utf-8?B?THZwcjdKV1VOVlpZdzdjUUl6eGxzV1cxV0RjM1JyNzM2SldxRVBSdjhSbmNk?=
 =?utf-8?B?T2xOdmExendUcVA5ZGZPYmlhdmwweTYyUjdjVjgwRitYbytJYTZSbi84Q08y?=
 =?utf-8?B?V3hCUTljYk1RN3NIc3UzTHZZZGhBTVBzdWZ4Ui9sNVFuTHpIeFMrd3VuNUl1?=
 =?utf-8?B?VGt4cnkxMzRVaFkwRWlHRm9aQTRESWF2VTFIbnJza3cxMlRZMHkxZkVKWUsx?=
 =?utf-8?B?cXZ4R3RBcjJudUVaak5ESjBFSVdqdjRWSTBEMTl0ODZQdTFYbGhudm1rV3J0?=
 =?utf-8?B?RlpiaXpHQk5xVm8rOHVHM3lBMzdlYmsvakpRejJ5bGRDaHBtL2IraW5PcXMz?=
 =?utf-8?B?cVg2ZklMeHJXOFpoaFp5NWJpYi9XS3RsR0I3amRDa3dLWVFxMGVOZ3RQRE0r?=
 =?utf-8?Q?sluoYguk2sFVLQCf3GAVzjqLDusqIldtL5QUU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8775.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VCt2UWdYSnM0d1lNQk8vZ1I1QlRrSVV6ZnNCR3JkdTNzdVFHQXdyNENhRnNC?=
 =?utf-8?B?anRya2czOUFjMUJTckY2azhzeGxOaHRoZHRLRzUxN3lTcHVkOVZWTGp2WERu?=
 =?utf-8?B?ZWQ1TlNkZEVIOUIvZTlVdkdRUFF1MUNTam5RaUNUSDFCS3VPMXNjNFp6UjJj?=
 =?utf-8?B?LzlxY2xiOFllTmk5TGFMa3pIUm5RaS9CM2dOZUpUVGxlV05sQ0ZGQnVrdDV1?=
 =?utf-8?B?TDV0ZkxPSGY5STVDajdxOGhRYmpEU0U2WWlzc1B3Y2cxRzFHZkZQb3dOVXd2?=
 =?utf-8?B?OWdTRi96czloOFVSQ3BhdER5Q254dlJBRFZxQ2c0dytYcGQ3a1lHbHJSYkdL?=
 =?utf-8?B?T2dBQ0pIZUI2VnpEZDh0RDZJMklUK0cxQURaQzRWbFlSSUZuT3NkTFdWRVla?=
 =?utf-8?B?S3VybWxFR3N5TG1xV09tWURkODZTVmswNmJTVGdHbnF3bEpjeFYwNVdZNkww?=
 =?utf-8?B?WEFYcGVRMXlWSUNoU2JEd1Q5TTYxYUlQbHpUUjllbjQ2VmNHSXpMY0lPT3Rn?=
 =?utf-8?B?cDdhWWhZSWJkUktHRE9nRjZpeEJnMlVBQWYyOUFXUUpuR2VEK1JJZlNGelJt?=
 =?utf-8?B?VTZVekt5Q0hEaEsrZ2RVenAzcHRoSjB1NVpXR0UxdTN1VmFRV3JwTkhvRGlT?=
 =?utf-8?B?eWpoK0hrMlVtOWh4bHhhMGJpV3BXc0kyV1lyajMvaFowMHlaSEpGWGFoQU8w?=
 =?utf-8?B?NzlZaWYrbVBBek1Cakw2OCtFUXNCd3h5WDZHa29jWEc0MFJQWnlzWXhld1Fk?=
 =?utf-8?B?TnA5R2RnUHBwYVVmMVZobGtnSlg4by9maThHSm5ia3h6ZlR5YWVQR2RESnVE?=
 =?utf-8?B?SFk2clNOb2NSZkR1eFhoeXp2ZlN5c1RXWEt1QWdkb3NPYUtxTzNIMndLd1R4?=
 =?utf-8?B?N0JJeTlwQ2FkdXE3TmF5WUlCM0lrdWhMWVlhemMzZVZiRDNneitqNlVMNjlF?=
 =?utf-8?B?R0h1Q3dlRXVCaS9FTXVGN2I2OTJxY3FaVzN6MGVXczVkZ21YTFpzN3dHdlpQ?=
 =?utf-8?B?MThxVWN6cFRZdWhld0QyR3A5V2xkdTdwbVZaS3cyUUNtN1hvZWgwajJJME53?=
 =?utf-8?B?cmprWmxGcHNja253MVJTMnIvR2RNS3ArQm9NWlFJelU1dHEwQkRnRThycWxs?=
 =?utf-8?B?M1NHdmtwdWFsaFBrZkR4Z0RWTTlWS0JGWkdMNytNOWdiTlB4cm5qZ3BIeUhC?=
 =?utf-8?B?bEYzeDFPYy91bmdmOTBNclNqZkFlY0UxTjIvVVBxcXk2TC9jdFprNWx0SFhT?=
 =?utf-8?B?NWpZdHZpZDJFeFNtT1BMNzliRDFWRzZPMC9QeVdxQk5hY1JZc1JrdjdqQm1t?=
 =?utf-8?B?YnQrK2ZxM2NPS1ZEZFdMTDA2ZnNXdkZsQkxsdVdDL2cyLzZxbkVqbTZUNGdH?=
 =?utf-8?B?eWw5K1ZyRlFkQStndFlLUEZneVBSVWE5WnFXUUhRNEcyT0JLbW1oaGF6ZGZm?=
 =?utf-8?B?TnllV3JOREZlNTNqRDhyblBCZkUydi81aWIwZFZHYk15K1JxL3VWSUVHMWZy?=
 =?utf-8?B?cTlYTXZzSHA0Ynp5N2JNeEFuWlJxLzYzek0yckttVmF6NjMwanNERXdNbEdt?=
 =?utf-8?B?cXdFWUlwdDNGdXpsUkx3cytkbjZzcWhYdGV4QmVtM3hkUW1ZZ3RGdWpkdVUr?=
 =?utf-8?B?cWVrbjVxKzA5Y3Nlanc2RVJTMmJ3eTNqR3ZEU05uSld4LzBEZ211LzlvMDNt?=
 =?utf-8?B?Z0dTMVZGWHlLZksrQ042aVN6cnVxUjI0NzBmK2kweVNtbmJuUS9ralJoQnNW?=
 =?utf-8?B?N2ZZSFBRSEZuVENXNVMvYk85ZGphZkZqTXJZSzZZRXliblVnM2V1WmorUHhq?=
 =?utf-8?B?L2pCaTBHcUxmZDFTNlhEV29MYzNwOExQbEpMNTd4MG9YVzhwRUFoRERiR1BE?=
 =?utf-8?B?M0FkR09pR0FMdlpjZmpjRHRFeTdLVksxYnpEcFN5YzhiWVh3NXplZ3Y2aEg3?=
 =?utf-8?B?eHZNaWlUU2RWNmdsaUZmSUFzMEEwYkIyU1RMOVFpa1loUlYzSmNhYXhzVDdD?=
 =?utf-8?B?NDNReWZLSEdZYkIrNDEva2JSU2QvdWRVSmtISFh3OThrTklaVCtFWWkvSG5X?=
 =?utf-8?B?L1ZPcWJqa1ZKR05qck13SW9KV0t0NXB4K2NIRG5aVERyZVV6UTdoWnYzMFRE?=
 =?utf-8?Q?Hhih7oMc6/0N1/q4Z/eYW9ZJU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E0B52F2E5D7A84E808581FD711102E2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8775.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f35c03-fa29-4a8e-a917-08dd07d582a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2024 13:32:55.7810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HcYezfXwcdNJ3HDG3iLllfpOhT5/UwHm8Kdz0Ry0pxHgoPtUiSzQatoiSvyduoJ6ctanB4RSxIwz6jjgy3FE3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6310
X-Outbound-SMTP-Client: 72.163.7.169, rcdn-opgw-5.cisco.com
X-Outbound-Node: rcdn-l-core-07.cisco.com

T24gTW9uLCBOb3YgMTgsIDIwMjQgYXQgMDM6MjQ6MjBQTSArMDIwMCwgQW5keSBTaGV2Y2hlbmtv
IHdyb3RlOg0KPiBPbiBNb24sIE5vdiAxOCwgMjAyNCBhdCAxMjo0MDoxNlBNICswMDAwLCBEYW5p
ZWwgV2Fsa2VyIChkYW5pZWx3YSkgd3JvdGU6DQo+ID4gT24gTW9uLCBOb3YgMTgsIDIwMjQgYXQg
MTE6MzA6NTlBTSArMDAwMCwgU2hpbmljaGlybyBLYXdhc2FraSB3cm90ZToNCj4gPiA+IA0KPiA+
ID4gVGhhbmsgeW91LiBIZXJlIEkgcXVvdGUgdGhlIHJlbGV2YW50IHBhcnQgb2YgdGhlIGRlYnVn
IGxvZy4NCj4gPiA+IA0KPiA+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiA+IC4uLg0K
PiA+ID4gcGNpIDAwMDA6MDA6MWYuMDogWzgwODY6MTlkY10gdHlwZSAwMCBjbGFzcyAweDA2MDEw
MCBjb252ZW50aW9uYWwgUENJIGVuZHBvaW50DQo+ID4gPiBwY2kgMDAwMDowMDoxZi4xOiBbODA4
NjoxOWRkXSB0eXBlIDAwIGNsYXNzIDB4MDU4MDAwIGNvbnZlbnRpb25hbCBQQ0kgZW5kcG9pbnQg
Li4uIFtBXQ0KPiA+ID4gcGNpIDAwMDA6MDA6MWYuMTogQkFSIDAgW21lbSAweGZkMDAwMDAwLTB4
ZmRmZmZmZmYgNjRiaXRdDQo+ID4gPiBwY2kgMDAwMDowMDoxZi4yOiBbODA4NjoxOWRlXSB0eXBl
IDAwIGNsYXNzIDB4MDU4MDAwIGNvbnZlbnRpb25hbCBQQ0kgZW5kcG9pbnQNCj4gPiA+IHBjaSAw
MDAwOjAwOjFmLjI6IEJBUiAwIFttZW0gMHg4OGMwMDAwMC0weDg4YzAzZmZmXQ0KPiA+ID4gLi4u
DQo+ID4gPiBQQ0k6IFVzaW5nIEFDUEkgZm9yIElSUSByb3V0aW5nDQo+ID4gPiBwY2kgMDAwMDow
MDoxZi4xOiBCQVIgMCBbbWVtIDB4ZmQwMDAwMDAtMHhmZGZmZmZmZiA2NGJpdF06IGNhbid0IGNs
YWltOyBubyBjb21wYXRpYmxlIGJyaWRnZSB3aW5kb3cgLi4uIFtCXQ0KPiA+ID4gaHBldDA6IGF0
IE1NSU8gMHhmZWQwMDAwMCwgSVJRcyAyLCA4LCAwLCAwLCAwLCAwLCAwLCAwDQo+ID4gPiAuLi4N
Cj4gPiA+IE5FVDogUmVnaXN0ZXJlZCBQRl9YRFAgcHJvdG9jb2wgZmFtaWx5DQo+ID4gPiBwY2kg
MDAwMDowMDoxZi4xOiBCQVIgMCBbbWVtIDB4MjgwMDAwMDAwLTB4MjgwZmZmZmZmIDY0Yml0XTog
YXNzaWduZWQgLi4uIFtDXQ0KPiA+ID4gcGNpIDAwMDA6MDA6MDkuMDogUENJIGJyaWRnZSB0byBb
YnVzIDAxLTA2XQ0KPiA+ID4gLi4uDQo+ID4gPiBQQ0k6IENMUyA2NCBieXRlcywgZGVmYXVsdCA2
NA0KPiA+ID4gcDJzYl9jYWNoZV9yZXNvdXJjZXMNCj4gPiA+IHAyc2JfY2FjaGVfcmVzb3VyY2Vz
OiBQMlNCQ19ISURFPTAgIC4uLiBbRF0NCj4gPiA+IHAyc2Jfc2Nhbl9hbmRfY2FjaGVfZGV2Zm46
IGRldmZuPTFmLjENCj4gPiA+IHAyc2Jfc2Nhbl9hbmRfY2FjaGVfZGV2Zm46IDI4MDAwMDAwMC0y
ODBmZmZmZmY6IDE0MDIwNCAuLi4gW0VdDQo+ID4gPiBQQ0ktRE1BOiBVc2luZyBzb2Z0d2FyZSBi
b3VuY2UgYnVmZmVyaW5nIGZvciBJTyAoU1dJT1RMQikNCj4gPiA+IC4uLg0KPiA+ID4gLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCj4gPiA+IA0KPiA+ID4gQWxzbywgaGVyZSBJIGxpc3QgbXkgb2Jz
ZXJ2YXRpb25zLg0KPiA+ID4gDQo+ID4gPiBbQV0gVGhlIFAyU0IgZGV2aWNlIHdhcyBkZXRlY3Rl
ZCB3aXRoIERFVkZOIDFmLjEsIGFuZCBkZXZpY2UgaWQgODA4NjoxOWRkDQo+ID4gPiBbQl0gRmFp
bGVkIHRvIGNsYWltIGl0cyByZXNvdXJjZQ0KPiA+ID4gW0NdIEFzc2lnbmVkIG5ldyByZXNvdXJj
ZQ0KPiA+ID4gW0RdIHAyc2JfY2FjaGVfcmVzb3VyY2UoKSB3YXMgY2FsbGVkIGFmdGVyIHRoZSBu
ZXcgcmVzb3VyY2UgYXNzaWdubWVudC4NCj4gPiA+ICAgICBQMlNCQ19ISURFIGJpdCBpcyBub3Qg
c2V0Lg0KPiA+ID4gW0VdIFRoZSBuZXcgcmVzb3VyY2Ugd2FzIGNhY2hlZC4gSU9SRVNPVVJDRSBm
bGFnczogTUVNXzY0LFNJWkVfQUxJR04sTUVNLg0KPiA+ID4gDQo+ID4gPiBTbyBpdCB3YXMgY29u
ZmlybWVkIHRoYXQgdGhlIHAyc2JfY2FjaGVfcmVzb3VyY2UoKSB3YXMgY2FsbGVkIGFmdGVyIHRo
ZSBuZXcNCj4gPiA+IHJlc291cmNlIGFzc2lnbm1lbnQsIGJ1dCBIYW5zIGFuZCBBbmR5IGRpc2N1
c3MgdGhhdCB0aGlzIG9yZGVyIGlzIG5vdCB0aGUNCj4gPiA+IHByb2JsZW0gY2F1c2UsIHByb2Jh
Ymx5Lg0KPiA+ID4gDQo+ID4gPiBPbmUgdGhpbmcgSSBub3RpY2VkIGlzIHRoYXQgcDJzYl9iYXIo
KSBjYWxsIGlzIG5vdCByZWNvcmRlZCBpbiB0aGUgbG9nLiBNeQ0KPiA+ID4gdW5kZXJzdGFuZGlu
ZyBpcyB0aGF0IGFsbCBkZXZpY2UgZHJpdmVycyB3aGljaCB1c2UgUDJTQiByZXNvdXJjZSBzaG91
bGVkIGNhbGwNCj4gPiA+IHAyc2JfYmFyKCkuIERhbmllbCwgeW91IG5vdGVkIHRoYXQgImEgY3Vz
dG9tIGdwaW8gZGV2aWNlIiBkaXNhcHBlYXJlZC4gRG9lcyBpdHMNCj4gPiA+IGRldmljZSBkcml2
ZXIgY2FsbCBwMnNiX2JhcigpPw0KPiA+IA0KPiA+IE5vIGNhbGxzIHRvIHAyc2JfYmFyKCkuIEl0
IG1heWJlIGFuIEludGVsIEdQSU8gZGV2aWNlIGFjdHVhbGx5LiAweDgwODYgaXMgSW50ZWwncyB2
ZW5kb3IgY29kZS4NCj4gPiBJIHN1c3BlY3QgaXQncyBzb21ldGhpbmcgc3RhbmRhcmQgb24gRGVu
dmVydG9uLg0KPiANCj4gQXJlIHlvdSByZWZlcnJpbmcgdG8gTFBDIEdQSU8/DQogDQogSSBkb24n
dCBrbm93IHRoZSBoYXJkd2FyZSB3ZWxsIGVub3VnaCB0byBzYXkgZm9yIGNlcnRhaW4uIEl0J3Mg
d2hhdGV2ZXIgZGV2aWNlIDgwODY6MTlkZCBpcy4NCg0KRGFuaWVs

