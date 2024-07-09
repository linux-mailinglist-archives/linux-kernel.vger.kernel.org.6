Return-Path: <linux-kernel+bounces-245219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC9F92AFDB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 08:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34E91B21C41
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 06:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3591369BB;
	Tue,  9 Jul 2024 06:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hX1bET1E";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="cdqzsr0C"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1DA823CB;
	Tue,  9 Jul 2024 06:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720505628; cv=fail; b=fGL1vg+RxaY0m1Nbc5F+GggoBYBjLFr6PXiHGob0K0pgOOyfd9714sHbHj05iRg96uzH790xzlcq3MQkAwpg43ugoJASn+h+v0gaMqL+FocCErcWhgoSro/DBVFj7uvw6NlEYDawXdJn5ipC3ZfAixFOhA4CpsZnsGFUqg6hoNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720505628; c=relaxed/simple;
	bh=c1Lg7hNfdAhn/0m+GjgLA1P2WqBjMc6yYLkdneaC/jY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=We5+ACAlmmiUXg4nlWw7wpBuossywm8LQsSxqX1NerQodbrBnGDLo0eFdje+yikN4Ch0VeqwhtNdjzdCsjlj9z7JJA3T43Addd3fCOdj0NKpSIQuXBj4PRQl7OgwjaTZUJEI9nezu/ASdp00LbcR28wq9IBhgVJ8KDHyhw4jRJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hX1bET1E; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=cdqzsr0C; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720505626; x=1752041626;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=c1Lg7hNfdAhn/0m+GjgLA1P2WqBjMc6yYLkdneaC/jY=;
  b=hX1bET1ENqQ/J4TtuEZlcq+RsDiwRAumTMUg6623x1SdHLJ5bU6h1V/W
   udQbFQ7kPqEWMlRnZrdHpUSgCPkuWRzOhAEe2L/DonV33kjC+YHPFCj1X
   EmdIGJc0JbVyhrKIukgBJHSSbK64+PicUAdlNwaMxStxbFHTsmcdFAWmX
   Q83wtMA0ohyI/m8i4ysgoj0CE1RiPdDXoKSJ/NeJh8JT0lmnerue5FyYV
   zPC/8t/ZxJIVfniSVxqyTxJTz1M5y9y3b+O4XHAbNJFkNGETjgUQZeJkn
   OQxqzqzAKuUXbTMGaoYAD7XJonumAWu/YuAnDosItcEMwCoyyfTdwBIMG
   g==;
X-CSE-ConnectionGUID: gjwWTA1XSEOEIYimU8FL6w==
X-CSE-MsgGUID: 7wwz7w/ATNCKuR8qC7nQ3g==
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="28994206"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jul 2024 23:13:45 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jul 2024 23:13:24 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jul 2024 23:13:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESVCN7AsvvnmbuOSRcq0PUUCGlDHG+nsZ5rw3MBTYINXTDgOmhjyd3waGjKLCUNFOvvDx/zi22aK0pCyesU1EU42KBJXf0oEFHdHPx33Q+t5RUcnTH1qL4sMRYMdXd4EpivHvM1yyq0gv9bStqznx4ITZ5kDsRstjAVKXc6u7Y/3GASKSu6taO8OcO+IRUq5VN55k+wj76tN+bqlrAXWZrcUG6AQRrBtMgD6e4Dr5uzefPeL4OeB2bV6Y256u0Yak41j2mAdkE0JNIptktWg09uFMOcqNXG9hqKe7PNzBDpkV4YbGq5kEowBMPE6vbaVg3wvXoX75s140ppg4mX+fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1Lg7hNfdAhn/0m+GjgLA1P2WqBjMc6yYLkdneaC/jY=;
 b=iC0jQjObFOeECdt34qdHs+VGdEOFJpc3Dt/xnXmd/hSCYEDzom8Jh71iE3Tb3kv6pqK/IipUJ26aBC9YLkNDhV493kYvthoQ41tye02HvcqtMu/lJ2xdjcvs0u9JWH5uJ1Ly8zd463Iz/Aj6L83airNtcshj8NXlRuxxq6bguPH2jG6yK9Dz4ZXeHJXKFJBU93Xaz7GvjBBrjkiA42SCPQgJ14k0Phwz9GY3CVE+eQMJC5gkeD415VWPpf0iBeTEXR4MasvCNQ+SdqrNN55Pq9NP5N49YeHzcEboKS5EC1dkDV1faCN/Va8Fp0cC7Q0YgJ+kuwCrongBKADP0XiXzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1Lg7hNfdAhn/0m+GjgLA1P2WqBjMc6yYLkdneaC/jY=;
 b=cdqzsr0CSiko2ajnFrHiqaMqes37/+8mPi+sTMb4V3NZ42WP0OSapaF1hmKGcPgxzBSSPdetACQXlVfkxnQpfw5jcTVqkf+BGeV81e+sfqr5suNRg6yOoAYvFbIXFb0SqND5r1faJNkbhuCRs7oKWhq4Lv4QUuyHDpHkpG2p2luHRPc09ilSkTFg1dthc1l+aZymrioE0tZIlo4muUwDIHedPW3O9qvjuFBzT6I1VCm/jJikYFqnGfKUT3787pu8yHTk4jl86KV4aVtp4bfwM8/PSVlB38GvU/Gtc19dEV4ojwkbOyaVn1hgDphgUnwCvLyScMpgeNdLlBv12+Y0UA==
Received: from SA0PR11MB4719.namprd11.prod.outlook.com (2603:10b6:806:95::17)
 by DM4PR11MB7759.namprd11.prod.outlook.com (2603:10b6:8:10e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 06:13:21 +0000
Received: from SA0PR11MB4719.namprd11.prod.outlook.com
 ([fe80::5303:b2dc:d84b:f3b2]) by SA0PR11MB4719.namprd11.prod.outlook.com
 ([fe80::5303:b2dc:d84b:f3b2%7]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 06:13:21 +0000
From: <Varshini.Rajendran@microchip.com>
To: <conor@kernel.org>
CC: <tglx@linutronix.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<Dharma.B@microchip.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 15/27] dt-bindings: interrupt-controller: Document the
 property microchip,nr-irqs
Thread-Topic: [PATCH v5 15/27] dt-bindings: interrupt-controller: Document the
 property microchip,nr-irqs
Thread-Index: AQHazTPJhfVxIL/qOU2szFNlRbZxeLHlJJWAgAjPN4A=
Date: Tue, 9 Jul 2024 06:13:21 +0000
Message-ID: <a41274c3-fd32-4eba-8240-bf95e41f63d9@microchip.com>
References: <20240703102011.193343-1-varshini.rajendran@microchip.com>
 <20240703102814.196063-1-varshini.rajendran@microchip.com>
 <20240703-dentist-wired-bdb063522ef7@spud>
In-Reply-To: <20240703-dentist-wired-bdb063522ef7@spud>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR11MB4719:EE_|DM4PR11MB7759:EE_
x-ms-office365-filtering-correlation-id: 8e6ab61c-bfe4-4312-0207-08dc9fde3c0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UERkWmNTcE5VdlMreWJ2RmZONERMbTlLL0ZUajJ0bUs1UWZmR3lJZEVtdEhV?=
 =?utf-8?B?NDV2ajE5MExOVkxoMy9yQ05zK1doYWdkTFhVdkdyZWhMY0ZsOEFhSytoM3NZ?=
 =?utf-8?B?UXFyeG85T09ES2M1cDAwSGMxT2gxSFB3a3BnNzRJNFZtVFEvWmhMRldIVVU4?=
 =?utf-8?B?VmNJQnZ0K25vcE9XM2NOUVpmWStwMmlOK0dZVHd3RHJOR29reCtBVDRSRlpz?=
 =?utf-8?B?WlB2aFlnZGNkaXpiWm1rWUZ0VEhjNm1haWtiSjUrcmJXY3RnL042azZvM0Qr?=
 =?utf-8?B?b1ZRUVorSWE0UzE2K0l2ZDJYY2VXeUpTek03K3RxVlVXT0tkN0NhMXBYeVYw?=
 =?utf-8?B?U3BqWjV0eVJraVFzb2dhY0NPMXREbzlmOFZ0a0w2aTJaVElLRWg1NHhCemc2?=
 =?utf-8?B?bmlTZUZxczRTaE9GQmNVdnRWNVpVZ2pwQVoybWFnWmF3T3BWc0k1MHdYSVlt?=
 =?utf-8?B?a2tpak4yVEp4UFN2SXd6U2l3d0wwN0plNGpaMVBrdEFqRGltTFFVYWFYem9y?=
 =?utf-8?B?c3YySVJiUG5FQzBKMjhBSURvR2RpQVlTVVZRQlNMbmNZSi9wQldEb1FRT2gy?=
 =?utf-8?B?ODBNbDNoc0J3U2xLWEFRNmUrYS9HN0hHdmN6YUNPRnI0dFJqaWhBK2xpQmEz?=
 =?utf-8?B?Y3lrUis2UEpBZlBCTFY3K3pEdWR0WlhqQ2d0MHNYWUI0RW1McTluQXhXVFMz?=
 =?utf-8?B?VFMvNnlVMlRnNTQ2dXhyN2ZueXRkU3pzRmY3R3BwOFhzTzBuTTBBS2pZRS9I?=
 =?utf-8?B?U1l4MXVoSEZsSnJIbDRkRGsrdVpLTTV2NDBmQ3V1ZVdqR3EzbnNKTmxDNTB1?=
 =?utf-8?B?SDF0RXd0a2dFVE5mV3pUMjBPbjRJL1lBaGdKb0UvZG5XTHExTy8rMWVMU0dF?=
 =?utf-8?B?QWo3V08xVW5WVVNzbDRldFNEbS83YTQwWWxDcERzcDVDTDVRdUhNdXlCZ1dD?=
 =?utf-8?B?STlKTUVUSUFpcnFvUGtHaWV4bDNRSitmL24veGkyeFdBOEs0VU5GV2szSG5Z?=
 =?utf-8?B?UDNPTTk2NzZJSU5JdlJDb2t1MkNESGI1Tm8vdEQxeG1PeFZXVXVDVkZFTUsx?=
 =?utf-8?B?REpCeTNETUg2S09KUVJQeGo3OXhnR2lwT0IvOEpETU5RQWwrcWhYemJNR1k3?=
 =?utf-8?B?N0Y2T09sWmZET01MeFlrWEp0SnJyM1J1YkFJL29abUYxOXl1RXY3dDliMWUv?=
 =?utf-8?B?N0lQc0pGdVoyQ3ZWaXJkd1pLV0ZNNlkvbHNkT3JaVUpScTRIRDh1ODk2R1JM?=
 =?utf-8?B?UXU0RStMQ3czakpZaFlKTWRyS0NhWHpTWHU4TFYxVWpjQlkrV3k3Uzk4SE82?=
 =?utf-8?B?RWZCQXo4Zm0ybHZTYnMxUThjdzBaL0Z3MVVldUxEUDBvSGthNG55Zlh5OVZ5?=
 =?utf-8?B?SlZIZ1FLTGQ4QThkT1NFcjZ5a3ZpSXpEbmFkZzQyeGZDdVpDdGtFNlpJclhF?=
 =?utf-8?B?bkJDTjlGQ1A4Q1NQVVRSNHRra0lYOFRyVU1QZjVrbEQ3WDc2eURYbHpxUzhk?=
 =?utf-8?B?NmgwZ2paSTE3eC8raU5tK29pZzZGM2dPV1NCRnpsN1VpVUZPYk9zL0hVM1Nl?=
 =?utf-8?B?TjlPTDZ1V2RZYnc4OVRadG9XVkxsakhVUmtkUFlaV2Y0RVB5TGRERmZqY0xj?=
 =?utf-8?B?akEvUkdoRStyaU1LaXVXbFhxVFZmQ1UzR21hT0o1UHdYbnBtMW9jOFMwVHJJ?=
 =?utf-8?B?RzVjc2cvRUgzWmtPUEw0bjNyUDJ4YUU5eDFUeERtbkRVTFljS0RpT0lEenl1?=
 =?utf-8?B?ZHVaTFUxdEUrcmxUeE0yUE1BMGh5RHBIazRDSmFiN3dZN0tBUFpxblAycHRy?=
 =?utf-8?Q?Irym4dovWtuTSzsvikjVqP9izYT87oHLg0Gcw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4719.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZC9GWWhieGxBQ3lTUTlobncxT2Q0RUhrZVQ3S3Rub1pPNHdEeFA2bmJEdnhN?=
 =?utf-8?B?ZE92M0p3WEFjd3JaQUVhd2M2LzAvUDBmTW4zS3FIL2lGS2VlUi9vNVh3Y2Jn?=
 =?utf-8?B?VlFXcGlyQUU5RWk4czd4QjBnS2M4Tm1BMWZIbEJEemxjbWFFVDhCRWE2SWFt?=
 =?utf-8?B?b1gwUXpnUFI5bzFVd3QxKzMrR1dlMVBSNk5WK1oyeTJNUFVRdWpPOG5md2VJ?=
 =?utf-8?B?TXplRlVTY1BJRXJQZHRSejdJSW9mUUJyWWN3MGZ1bHQyeTBsWlFHWFdUY3FE?=
 =?utf-8?B?MXpjNXlPdWtPYmVjTHNIWTJ6SzRVWDZQQ0p5dHc1TzNDbHRYUWZrUkxYdEth?=
 =?utf-8?B?NWNJTC9FSDF3djZnWGxWbTh3UE5PdTRaWGZUckhzaWhqUlZQZmowOGtVQlNE?=
 =?utf-8?B?OHIzbm5sblZBbDZKN2ZxQXpuK0JNYlI2Nkx4ZDI1TTFVTzhIWlBOSmVsaFlt?=
 =?utf-8?B?cXA4eVFleVVnbFFJZFBJaVVnYWRVU0I0dVlHd25mWmNKZStFcC9YZmlGYjN4?=
 =?utf-8?B?Tk9EZVpCcGs2Tk1jTWYzRDBBTzB0aG9HUzlWUTdoN0JTT1hLclJOdXhmV1Zm?=
 =?utf-8?B?cDJ0M01GTkk1Y1BRajM2WUM5WmgxYlJ1UGUyMVIrUzlidURUMWJUQ2toMHpl?=
 =?utf-8?B?TlpsQ25iRlIwMlh0NHdQRjZtT1N5VXNrcDVSelQ0WnRrK3g0T3BGZklVUnVr?=
 =?utf-8?B?dWg1V1dPcFVuRVVvZTFhYnpHeVFwdUs1REcxdUJSQk8wTzJVYnlJNmxxeW9p?=
 =?utf-8?B?QkR6bTlvNUdhWXd3d1VNQnhaK3pRY1BsaTlGZHplakdDZDdiaXNMaFJFb1hH?=
 =?utf-8?B?SDZSTE56dWRzR1hydDYwVEVGR0RKTnYzVzhFdTRKRmtTRnR3bkRyZHA1S2x5?=
 =?utf-8?B?aUwzb1hycjdseThMMnRNQWV5c1Y1dStQa3ZpMjY1ekdLbkQ0SzdtM2k3RWNv?=
 =?utf-8?B?TjdYN1NMLzg5cE9Ndk5MLzN5VGtLVzR1ZG5TbUFpQmo1aC9SSmUvVU1vdEgr?=
 =?utf-8?B?M1hyVkFVU1V6T09xcmlWU2ozeWsydWhuejg1aFE0K3hWSEFFNVJzQnNXNlgr?=
 =?utf-8?B?REFPVkROcFl1MENQYlkyZmRranZ5N0JKdVNmY0hCZkczUVJJaFFZbSs4R2x1?=
 =?utf-8?B?TlVRTDJNMHhjRjFQMG9oeHk1aFpCMkhHUGQyK21ZVGVLQlRVQ1JvNEw0UUZi?=
 =?utf-8?B?a0ZCYVZDSUI3MmloTU1ZTW94MHlvcXZTRHBhbFJrSWdnais0UXBJOVAwMzFw?=
 =?utf-8?B?dUZVUnFHMnFDUzhYa3kxZi9YaXpaeHBLYml5SURyL09zU1lnZVRoMDduRkk0?=
 =?utf-8?B?dlZ0TklnMlp2ZVo0RHJkSzUzbzREM2lpZmpQNEpJVC9XWWh3dStRc1I5Ritk?=
 =?utf-8?B?dDlzZEdabUw1aFkyNzNneTRIRVhFUGlsNTZlWTVTd3VrcU0wVngxRVVKSm1K?=
 =?utf-8?B?bUZnb0ZFanZtTjBmQjhwN1ZPQzNHd1VlcnljbTFHRG9PdmJzVit0bnF1eVpm?=
 =?utf-8?B?YWs2VXJMMHgwMzhUQk9sSmc1MEhkMWI4emtLUDlBTjhMYi9WVDFlb0luWWxS?=
 =?utf-8?B?VnpEOVcyd2RZVGs1dGhEa3VCVURlU1hYM1lUNWlIamZ2UFNUVnhDRWsvbHVD?=
 =?utf-8?B?M0JIWnFKVVczVXJxVXV2OFd5aS9mWHA5aUs2c1dRcWVpMWcwcDRYbnljTVBt?=
 =?utf-8?B?RGNJc1dXSjgrUTliMW1mK3VpUkx2QzBVOG80cnlZVFlyNkMzbkdGdTdmNFNt?=
 =?utf-8?B?NFB0b05rUWJMSUlOb2k2eisxWUxRaFJiU256NnJmY2hjdTdSL0YxcW16WmVS?=
 =?utf-8?B?U3prTXJVdGRLdkM2VU5nNU16dzVZNWlGSGpDMW9NQXVkNE5uRE1sTWRvL1hj?=
 =?utf-8?B?QTdqT25FSUdvRjdlRVVUT2l2Sk5nU1BVTHMyWVhxZ3cyQ2ZFcm5uQ0hhS255?=
 =?utf-8?B?MzBVWHFZZ0JTWWpVam9SNFMrSUlKMFI0R3VLTU9MbHdQZGRTWXh5RWkrNkxv?=
 =?utf-8?B?eXRGN3BJSTRCUXo4TFJCNFBmRGx1S0VqSHJUQVBMVmpuU1NSclVqbld0c1hq?=
 =?utf-8?B?SDgwRm55UGJuMkJwV2RlQVcxMWs2WG9Sb2VMbHdmamhPM0NJaUN1L3o0d0t5?=
 =?utf-8?B?UFhxeTdKV1lHMzY1NFA2YjAvYmFiazNzQzI3SmJ6cGREUTBPcjZ6N1U2WDBx?=
 =?utf-8?B?QUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <201E31C1DCC8EC4AACC5295262BC5484@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4719.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6ab61c-bfe4-4312-0207-08dc9fde3c0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 06:13:21.8617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uwikyEbIbGqA6SRFB5mOuWvcmkyYzEUAh3bv89ti7+9K2PqGMY4hO+QltlZlAaQuUfmIwR4jAl1Kffcw2AggdI5J7b50S6UAozFzi0BdAS6Bk5ZSft9efQteP9+8N3zx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7759

T24gMDMvMDcvMjQgOToxMSBwbSwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBPbiBXZWQsIEp1bCAw
MywgMjAyNCBhdCAwMzo1ODoxNFBNICswNTMwLCBWYXJzaGluaSBSYWplbmRyYW4gd3JvdGU6DQo+
PiBBZGQgdGhlIGRlc2NyaXB0aW9uIGFuZCBjb25kaXRpb25zIHRvIHRoZSBkZXZpY2UgdHJlZSBk
b2N1bWVudGF0aW9uDQo+PiBmb3IgdGhlIHByb3BlcnR5IG1pY3JvY2hpcCxuci1pcnFzLg0KPj4N
Cj4+IFNpZ25lZC1vZmYtYnk6IFZhcnNoaW5pIFJhamVuZHJhbjx2YXJzaGluaS5yYWplbmRyYW5A
bWljcm9jaGlwLmNvbT4NCj4gVGhpcyBuZWVkcyB0byBiZSBwYXJ0IG9mIHBhdGNoIDE0Lg0KPiAN
Cj4+IC0tLQ0KPj4gICAuLi4vYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvYXRtZWwsYWlj
LnlhbWwgICAgIHwgMTIgKysrKysrKysrKysrDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNl
cnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9hdG1lbCxhaWMueWFtbCBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9hdG1lbCxhaWMueWFt
bA0KPj4gaW5kZXggOWM1YWY5ZGJjYjZlLi4wNmU1ZjkyZTdkNTMgMTAwNjQ0DQo+PiAtLS0gYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvYXRt
ZWwsYWljLnlhbWwNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9p
bnRlcnJ1cHQtY29udHJvbGxlci9hdG1lbCxhaWMueWFtbA0KPj4gQEAgLTU0LDYgKzU0LDEwIEBA
IHByb3BlcnRpZXM6DQo+PiAgICAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0
aW9ucy91aW50MzItYXJyYXkNCj4+ICAgICAgIGRlc2NyaXB0aW9uOiB1MzIgYXJyYXkgb2YgZXh0
ZXJuYWwgaXJxcy4NCj4+ICAgDQo+PiArICBtaWNyb2NoaXAsbnItaXJxczoNCj4+ICsgICAgJHJl
ZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyLWFycmF5DQo+PiArICAg
IGRlc2NyaXB0aW9uOiB1MzIgYXJyYXkgb2YgbnJfaXJxcy4NCj4gVGhpcyBtYWtlcyBubyBzZW5z
ZSwgZGlkIHlvdSBqdXN0IGNvcHkgZnJvbSBhYm92ZT8gV2h5IHdvdWxkIHRoZSBudW1iZXINCj4g
b2YgaXJxcyBiZSBhbiBhcnJheT8gV2h5IGNhbid0IHlvdSBkZXRlcm1pbmUgdGhpcyBmcm9tIHRo
ZSBjb21wYXRibGU/DQo+IA0KU29ycnkgZm9yIHRoZSBiYWQgZGVzY3JpcHRpb24uIEkgd2lsbCBj
b3JyZWN0IGl0IGluIHRoZSBuZXh0IHZlcnNpb24uDQoNCkZvciB0aGUgc2Vjb25kIHBhcnQgb2Yg
dGhlIHF1ZXN0aW9uLCB0aGlzIGNoYW5nZSB3YXMgZG9uZSBhcyBhIHN0ZXAgdG8gDQpyZXNvbHZl
IGhhdmluZyBhIG5ldyBjb21wYXRpYmxlIHdoaWxlIGhhdmluZyBwcmFjdGljYWxseSB0aGUgc2Ft
ZSBJUCANCnBvaW50ZWQgb3V0IGluIHRoZSB2MyBvZiB0aGUgc2VyaWVzIFsxXS4gSXQgaXMga2lu
ZCBvZiBsb29waW5nIGJhY2sgdG8gDQp0aGUgaW5pdGlhbCBpZGVhIG5vdy4gRXZlbiBpZiB0aGlz
IGlzIGFkZGVkIGFzIGEgZHJpdmVyIGRhdGEsIGl0IA0Kb3ZlcnJpZGVzIHRoZSBleHBlY3RhdGlv
biBmcm9tIHRoZSBjb21tZW50IGluIFsxXS4gUGxlYXNlIHN1Z2dlc3QuIEkgDQphbHNvIHJlYWQg
Um9iJ3MgY29uY2VybnMgb24gaGF2aW5nIGEgZGV2aWNlIHRyZWUgcHJvcGVydHkgZm9yIG51bWJl
ciBvZiANCmlycXMuDQoNClsxXSANCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvODdlZTFl
M2MzNjU2ODZiYzYwZTkyYmEzOTcyZGMxYTVAa2VybmVsLm9yZy8NCg0KPiBUaGFua3MsDQo+IENv
bm9yLg0KPiANCj4+ICsNCj4+ICAgYWxsT2Y6DQo+PiAgICAgLSAkcmVmOiAvc2NoZW1hcy9pbnRl
cnJ1cHQtY29udHJvbGxlci55YW1sIw0KPj4gICAgIC0gaWY6DQo+PiBAQCAtNzEsNiArNzUsMTQg
QEAgYWxsT2Y6DQo+PiAgICAgICAgICAgYXRtZWwsZXh0ZXJuYWwtaXJxczoNCj4+ICAgICAgICAg
ICAgIG1pbkl0ZW1zOiAxDQo+PiAgICAgICAgICAgICBtYXhJdGVtczogMQ0KPj4gKyAgLSBpZjoN
Cj4+ICsgICAgICBwcm9wZXJ0aWVzOg0KPj4gKyAgICAgICAgY29tcGF0aWJsZToNCj4+ICsgICAg
ICAgICAgY29udGFpbnM6DQo+PiArICAgICAgICAgICAgY29uc3Q6IG1pY3JvY2hpcCxzYW05eDct
YWljDQo+PiArICAgIHRoZW46DQo+PiArICAgICAgcmVxdWlyZWQ6DQo+PiArICAgICAgICAtIG1p
Y3JvY2hpcCxuci1pcnFzDQo+PiAgIA0KPj4gICByZXF1aXJlZDoNCj4+ICAgICAtIGNvbXBhdGli
bGUNCj4+IC0tIA0KPj4gMi4yNS4xDQo+Pg0KDQotLSANClRoYW5rcyBhbmQgUmVnYXJkcywNClZh
cnNoaW5pIFJhamVuZHJhbi4NCg0K

