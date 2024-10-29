Return-Path: <linux-kernel+bounces-386232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFA09B40C0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 04:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF8621F230BF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 03:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0251F429A;
	Tue, 29 Oct 2024 03:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="V9ovdaKa";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="B3pieIcr"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ED91FAC33;
	Tue, 29 Oct 2024 03:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730171110; cv=fail; b=Nme+yTsTtW0ebcXLPqnV1pa8UgzHHPSFX57A6aZlqvNEwO6D1jmMqXjF9thkojZ89nNztf0Zkf5KLdDyuP5R3PFWb/4kc1IGj4tpKgonENCpBoe3NitAjpNK5OoO7wa9Ee2Ol6auGDCfcLJGnl7XSoI9Srg5lQjtlDmDRy7d5Mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730171110; c=relaxed/simple;
	bh=fNLEr++TpoXxVMlt2RG9wKAaftVAln3b1u/UaddREQc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ac6wNOcv1Cj5GTjBNaSVTGcPrOxIiv86JjgLWDf+AQcneFwmqQMFMBU34r+KWn+nZzsgKKmHBr++ybHz9/bvO1YOD5Yyvz7g8OVx3hXd8PQzRiRPzZdHJCtNCjTCab4/5K4GPZf95NpImD8rH7cL1mxYFPs/8m0HkbZL8QWPFc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=V9ovdaKa; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=B3pieIcr; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9636364c95a211efb88477ffae1fc7a5-20241029
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=fNLEr++TpoXxVMlt2RG9wKAaftVAln3b1u/UaddREQc=;
	b=V9ovdaKao/Sp9uNIye/cmp4+YIc7LXkuhh+3gleela5bcsHlQGulK9o5+eUQru5fPYpPn5GfFzIo5XL2VPx2k5+UNTcbQFNs59QAYsrfV+ka7Zf/zRwP+HB2NaTFnZE9E4fa2VuXnXMT8zLaB0QYnDAZehedf2LJDHh2mWTIXHo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:34553cf6-2d18-4e15-a347-784331107c01,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:96c95648-ca13-40ea-8070-fa012edab362,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 9636364c95a211efb88477ffae1fc7a5-20241029
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <trevor.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 460291884; Tue, 29 Oct 2024 11:05:00 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 29 Oct 2024 11:04:59 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 29 Oct 2024 11:04:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWfq7G9Thh2wAlArWKyFi7nLDuy9Lsb3yGqHttnmhXqzra5DROWmg6cy1rWW/K3MIjaPyCQQcffakPgYSpIIBkSdASOH9fNucwY+VHnUhE5CZlCFpx4nf0KOZ/uNWH+gMiyIaL7DlExTjCeRh2P+fwAgssX48O/+Bd72MWXPObjqLmHam47ZuChEL5CCE9jzwtjkYDhN664FzFrpMC0reOhH70ns6xsBApXYn7KQrdhrrvBEzs65Rg5fm2OKEHEOsUySyPPLJVJpBTjkDqgicIGORJ6u/VbRZE6w4LURH1Beslr3PGB9cmZQF/pkfMAuwWPmVcosLOLtRcnpY3ulRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNLEr++TpoXxVMlt2RG9wKAaftVAln3b1u/UaddREQc=;
 b=D0jA6zgDvHy3f0fgIFhbZZGRTgpm6aytWkF+ESm5Knz575+OAIpby3kQbmUypMVHPN3n8pIzTAiaM5LKHljEC22+d0hXJMBqJ5oAXo5BJbQKGOnPF3IWgTwAQ3/Erx7QZvG2oIDxHJrQUw5/he8OHjP1uPsCxtEmBr8K1/tMJpPon9KWLJahPD2VRCRBtmtJuzAHVIgT0ptevNbAayThKvfusIl+5zSgRLbVORYi3G+C1I7UW+jBs8FT5E6Fft2yXzITuYZ5rQzXXau83+oU7keZZgGT2+Hje7BzUToQ/Ew96foZqTY5r8wYXb43UoduWW+d5u7bPogaek/4oRg/qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNLEr++TpoXxVMlt2RG9wKAaftVAln3b1u/UaddREQc=;
 b=B3pieIcrgF4IB5YJnexaWv5E8rmURa9rG0ukUxNjYqAvjZabh5+7GDwewlaQSRbivY5aGySpD/zJbIZm5mlVrHqTMvOLRvsQm3u1iPxo9UZCcw6EzkYLqRekuwIt0ji1qOBMm0WuuHEGyig4HceD+0Fj5+gIqYABDDyHiJ1tb0Q=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by TYZPR03MB8750.apcprd03.prod.outlook.com (2603:1096:405:66::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Tue, 29 Oct
 2024 03:04:55 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::e70d:eef9:eaf3:c45]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::e70d:eef9:eaf3:c45%3]) with mapi id 15.20.8093.025; Tue, 29 Oct 2024
 03:04:55 +0000
From: =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To: "fshao@chromium.org" <fshao@chromium.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "krzk@kernel.org"
	<krzk@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"broonie@kernel.org" <broonie@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"lgirdwood@gmail.com" <lgirdwood@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: dt-bindings: mediatek,mt8188-mt6359: Add adsp
 and dai-link properties
Thread-Topic: [PATCH 1/4] ASoC: dt-bindings: mediatek,mt8188-mt6359: Add adsp
 and dai-link properties
Thread-Index: AQHbJssnY/wBxburkEOZcDvK/t3GVbKbFz8AgADvJoCAADaWgIAA1BYA
Date: Tue, 29 Oct 2024 03:04:55 +0000
Message-ID: <5b55f75f2fc8a783bf2fdaeac80fd5954e16a2c8.camel@mediatek.com>
References: <20241025104548.1220076-1-fshao@chromium.org>
	 <20241025104548.1220076-2-fshao@chromium.org>
	 <5vmfh2nkxtpzt2vk4j6ghro7z5stoyvry3enzoqepg6hjxqrho@fofs5cwa2iqq>
	 <CAC=S1njPjtvhsc+voNK447wbQmRiN0xVDi-jgOmba4NLRiNi0Q@mail.gmail.com>
	 <20c793fb-cfdf-4c05-a421-3eb623ff6df0@collabora.com>
In-Reply-To: <20c793fb-cfdf-4c05-a421-3eb623ff6df0@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|TYZPR03MB8750:EE_
x-ms-office365-filtering-correlation-id: bb1c716f-296e-4604-572f-08dcf7c6771b
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QTZHMXNLNmR4djdaSzNucDNoN3gycnlFSkJybkY3TzNGZ2pSSjc2UVNBeUlm?=
 =?utf-8?B?N1FneVUxaVhMTDZsNklSVWorLzdJMmNMV2tCK3NVY0JYd3p6V2N1QXdoU2xI?=
 =?utf-8?B?ekdKaFo0aDVvLzErTVVGcndrSGVmNHdaRXY1eUdDTzZhUXp2Y3VUWklmNi9p?=
 =?utf-8?B?NCtSWWo3R09BN2NSUHJLSlE1Syt0aS9hdHVhNGhac2NGczd6SHk4RlQvUzBw?=
 =?utf-8?B?WWNzMmlkWkNlTGthMkJZUUxvKzlxamsrRS9VYzNELzNCWS9GMXR3QTgvRE1O?=
 =?utf-8?B?NFUwbkdVSHZnZ1JEbUFzK0hwYTRPU1U0bVdHYXNtSWcycjdXQ1JoU29Da1JT?=
 =?utf-8?B?QlR3b1ZUcTc4OHJ3NGVua1VtM0wvaDhmQU5iQlRNSUFtNEowK21nOGJrS295?=
 =?utf-8?B?b2l6QVBoaUdTWHFSODliajhOK0x6VWJPUFM5bXVrZUVuK3lUcXU5RkRwbHR0?=
 =?utf-8?B?SHEwKy9MTFExbGV0ZStNbmZrMXg5b1V6a0U3V29XNGJCbWsxZTFSOUlaR0o2?=
 =?utf-8?B?bTNOc1F6VHJ6aDl3SHdyOVFuOXZNbWtpWXE1SHlhRU91Sm9HNjlKLzBQd0tv?=
 =?utf-8?B?Q3JpYU9RTmFiZXRTNVpIR0xmYVZlaDVROHRNSHRXNzFYNENuQ1Y3Q0p5RXIy?=
 =?utf-8?B?V20yeVB4dlNCVWRBUFdxT0hIUXNUWDdPQTVKeXhpYmVTbkc1UXlMTW5XWEVM?=
 =?utf-8?B?NzQwWkdNRlV4QVpvdjRBSUpoNk9vTVh3VHZXVXhIMk5Nd1Ridnh6UGxJMUI2?=
 =?utf-8?B?bk1QN3VvcTVJeHhCdnNYTkYySjNrVURYK1lvWmNpRjkvVzBJV2h0WFJNalA0?=
 =?utf-8?B?SzR0MjZRejV2N2t6dVpoRTVFaThZV240TXFDMkxmcjRUQnNVeTFoaTJNRm1i?=
 =?utf-8?B?NStnMHN4UlBDOTQ5VFMrVlREQzNTWTB1cHl4RGF5WHZ3OGFxNi9JWTh6RTd3?=
 =?utf-8?B?NDEyNGl3QURmZjdNdVBCV2lmOVpGclExQjR3QnQ3ZWQ4T2lWR3d1ZXQ1SXVC?=
 =?utf-8?B?UE5XOHZLR1daeENHblhRTmJzNDcxdXJIeEREWDM5Q2VGaEp3NmpGanQyN1lM?=
 =?utf-8?B?VXhoa3Z3ZnZGTE8rOHdOZ0kvUkFyVGZzQTMxQVBwM2IxOCtiYjFSNkxwdUdu?=
 =?utf-8?B?VWFaMzMreHgvanZpaTEyMW93UVZQUXpNYldvSmx1MlhFZzVhZGVONTkrUkdJ?=
 =?utf-8?B?NjZPSlFHV0lacTIvMmxTN1ROTnVDNUx5Z2RwVmNzV05jVjRNWUZqWEJlWE5q?=
 =?utf-8?B?eFNVU1ZxYVJRbWxrTEpZQkJkY09RU2k4a09PaUFhT1E5WFlpSTVUdjU1SDRD?=
 =?utf-8?B?cGVXT0JibFRXZGJpL0J5RkhFRnRkSW4xazR1dTZTRG9oYjJzamEycWQyNUFQ?=
 =?utf-8?B?ZkVKTk9KNWpRaENJQ0lBblZmN3Zxa2lHZE5Mcy9qZEg5QWt6OGNzZ282VWZS?=
 =?utf-8?B?cXVzNWxQYk5VbTEwYWdGRVZhVXhTVnBJS0ZhVEd1TWRoZnRobnlGOU1PWlFS?=
 =?utf-8?B?U1JiMTY1L1J6NkJSMVpUTXFpK1NURzhCbjlGaVhhcmtBSS9IU3RsK09QZkVT?=
 =?utf-8?B?c09SbWdRR1kyZWwzL0loT1NYZnVuamh1VWpCNk96NUNVdEw4d3pHOE1VYlo5?=
 =?utf-8?B?RTgrMVRudVRvODF3eVJqUXoyT0pFRG5LODFvK3FlZTBtbVlxeE0zUlBOYi9o?=
 =?utf-8?B?ZmloSGZMVWVkYXB2dytWclNnM3BUVFNLa3BuTnVRRGo3MXYya3NaakRUVFo0?=
 =?utf-8?B?QndvNTVVNnkxZDNoVjQ3bCsyRjhEL2U3d0hGY2tReGFCWTNlQUdyelY4Wmkz?=
 =?utf-8?Q?JzceB48b1zxu2TmI/7n95Nes9YVGV16efmeOo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bEJhNjVKekFTNUVVZDlHRGM5QWZuK0IwYVF1RktVR3h4Mmx2RnpOVlU1RnFN?=
 =?utf-8?B?U1ZncGJSd1RabkliTWQ1c0FEeGZHVjd3aysyNlRPNVpkTjdiRHNZQ29sUDBK?=
 =?utf-8?B?dXJ5a2dmejhXNTBINGFnUHU1SDEwYVpzTWxVUDRQVzNkQ24zZWtGSDJWOWJN?=
 =?utf-8?B?ZG5kK3NwVXFPdDA5UXVodFV6aEp4OGRtK283SmJVdUsyaGkyS2kwWjdBZjBW?=
 =?utf-8?B?MEJWMkYyVmczQllFUStHK2NXYUZCbENKQjZ2U21iWTFyUzVVVWVwMVlQcWNH?=
 =?utf-8?B?eVY4cDJienRkL0R4ZGx4NU9MWFFJVFVoQnlYMFhUOGhjNGoyL1dKSmJTRXN1?=
 =?utf-8?B?MmYrVTdVdXhaNzBpVEFQZTN1UFgxdElISVlwdE1vbzlsM0hRKzFJcXpHVm5r?=
 =?utf-8?B?cXdsL0FicVpjTk1CUHNhdzRDY01VaWM5V3Z1QWRWSFJFVjRMaXJvK2lxdHRn?=
 =?utf-8?B?SDQ1YnVCM2cyQ1NROGZpam1jb0tJRXBXV01QbHdvV0c4d2luWisxdlZmQkM0?=
 =?utf-8?B?bW9naWlMTWtPZDIzOUEvVEhRS0RiVEFRc2FBQngzekRSeE0ya2l1SFl6aTRj?=
 =?utf-8?B?UmhlWXl0ZjNwQThLaFFPbzRjYWcxNUFLWGR1akplaGV4ZWJPd2pzMWE4NE9s?=
 =?utf-8?B?Y0tkQTF5Qm5makQ4VThGSisyQ2lldERQUGdKR2VYalpxSksycUoxSFVKTS9R?=
 =?utf-8?B?VHJBd0xrdUZWMFJxeWxYSmk5dXAzRFplU2szN0tabzZYNHVueGY1bGNPN3U2?=
 =?utf-8?B?SUU5OUYvemJ4VklIOTVmUjBqS21DakJDUzBzbk5LL25DaWYwaGljNldrL3JO?=
 =?utf-8?B?eElvMTFtVXpYczMvUTJCOEFGV1REeHhBTnJWODRwc3JjTFNua2hHTktWdVdu?=
 =?utf-8?B?UFJ5dDM2Ly9iRjlOZnhWeUxrUlpkdmEzbVVJbE15ZGFncFM1QTV4RW9ScXRn?=
 =?utf-8?B?UEJ4NlNIQytzY3AraGlBZWNzOHg1T0h4aE5XOFFYNW1FejcxY3hsWm1KNE4x?=
 =?utf-8?B?UmdsVW0yRzNsdTdsMlljSUVIR1l4NUUySHZxbVZwZXA4TVorSWtKYTdnaW9P?=
 =?utf-8?B?S0psNUxoZCtMNWdocEhybmlLY05qY3Q2TCsxam5JWm9sTTRYS1VTbDlIZzYx?=
 =?utf-8?B?aUEyQ1lrOFcwOWxwMkxjR0xBdXlpUnV1c3RrMDN6UWpmNlZzcS82RGRudTAr?=
 =?utf-8?B?S1VlU0NtM3pmTHQ3Mzd0OXlQZFZCRTNWYmRBZjhoNWNvRjJJYXpqazdsZis5?=
 =?utf-8?B?b29VVkNvV0tlK0t4QXkycjQvSmRSR1ZhRDNiQUNkbUMwNHpWNUl2MmpYRzVY?=
 =?utf-8?B?RU1BdGtLNHFRSUlOL2QwZzVMbWZTTE05Vm8vR25ZbE15aDVFWllTY1p0Z1cx?=
 =?utf-8?B?aHZHUE52SU1qd1JtYUFMc2g1OHZmc0JXN2l1ZGRXQTczMHpyNXBVbWxJRUlK?=
 =?utf-8?B?cTdTN3dXcGFrWU5WSFZxTCt4akQzMjJFWlZzaGRZSDg5NGkzU0dOcXlmTWN1?=
 =?utf-8?B?SHl5OHBNT0ErMkcwNndaZFpEU0JqVGZnODZwMHBteTlmZjMwNjM0Nnl0V2ZE?=
 =?utf-8?B?U1lpUEhSOG9aV1ZhdGd1LzRvYWhhRGlsT2lkbmhxUklXQ0dzQ0RRK1dmWTJI?=
 =?utf-8?B?Ti91THBlNFBTSnVXYTFnck9BdGpoTVUzK1hYZzBERktNZzByUHRBbnpDZkV0?=
 =?utf-8?B?Wm41YmNNN0JUaXRHOGVoYUQvL2M0VVlWZ2RWU2R2ZHAyMTFZek5zQ2IxaW1x?=
 =?utf-8?B?Nk15RVY4SVRkSTB2TnBmdzA0UG1KeWkra28zSSswcG9YWTdrSHEwYUg5WVA4?=
 =?utf-8?B?eEJXb0l4M3ZCWkV5TFhnWkZMUkdSeGNObjA5T0xxeEhtSjVlcXVYNHVXT0Vh?=
 =?utf-8?B?SkhNRzIyRFhNZGRqVnJGR1J6VGdSRHhSb2NEczJxZ3ZzQkJSYTJuWU9vcEtj?=
 =?utf-8?B?STl2YTlISEcxTVp0ZE51bFJGVXVGTWxseXRzdzh6eEQva09pLy93VHF4WGZj?=
 =?utf-8?B?YUlGUlNpMjFheDd2cEVzQVZkWmlNKyt1NHg3KzVmNmZIbXQ2djZSSXlnTStp?=
 =?utf-8?B?VHFlcytxRmFGSExVNk1ibWUvR1pFK290MEFURGczL0JUbk80WUk3Wk9lL3ZS?=
 =?utf-8?B?ZVRwdCt5REdmOThhSzI1OVE2UDNwV1UrRDhJRUxhcjNKSDI4UFBiUThLYndy?=
 =?utf-8?B?Y2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <023648EDF50AE542B41CD18EAB9F9AA2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb1c716f-296e-4604-572f-08dcf7c6771b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 03:04:55.3119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JhLq4cj0EA7qUO8/mSuzyO21Gh4YAlO5pp+TfvLAeFIOxf4epJ104FOshHXPzazAIOqtWeqq/UYx12WVPK82gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8750
X-MTK: N

T24gTW9uLCAyMDI0LTEwLTI4IGF0IDE1OjI1ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAyOC8xMC8yNCAxMjoxMCwgRmVpIFNoYW8g
aGEgc2NyaXR0bzoNCj4gPiBPbiBNb24sIE9jdCAyOCwgMjAyNCBhdCA0OjU04oCvQU0gS3J6eXN6
dG9mIEtvemxvd3NraSA8DQo+ID4ga3J6a0BrZXJuZWwub3JnPiB3cm90ZToNCj4gPiA+IA0KPiA+
ID4gT24gRnJpLCBPY3QgMjUsIDIwMjQgYXQgMDY6NDQ6NDFQTSArMDgwMCwgRmVpIFNoYW8gd3Jv
dGU6DQo+ID4gPiA+IEFkZCAibWVkaWF0ZWssYWRzcCIgcHJvcGVydHkgZm9yIHRoZSBBRFNQIGhh
bmRsZSBpZiBBRFNQIGlzDQo+ID4gPiA+IGVuYWJsZWQgb24NCj4gPiA+ID4gdGhlIHBsYXRmb3Jt
Lg0KPiA+ID4gDQo+ID4gPiBXZSBzZWUgdGhpcyBmcm9tIHRoZSBkaWZmLg0KPiA+ID4gDQo+ID4g
PiA+IEFkZCAibWVkaWF0ZWssZGFpLWxpbmsiIHByb3BlcnR5IGZvciB0aGUgcmVxdWlyZWQgREFJ
IGxpbmtzIHRvDQo+ID4gPiA+IGNvbmZpZ3VyZQ0KPiA+ID4gPiBzb3VuZCBjYXJkLg0KPiA+ID4g
DQo+ID4gPiBXZSBzZWUgdGhpcyBmcm9tIHRoZSBkaWZmLg0KPiA+ID4gDQo+ID4gPiA+IA0KPiA+
ID4gPiBCb3RoIHByb3BlcnRpZXMgYXJlIGNvbW1vbmx5IHVzZWQgaW4gdGhlIE1lZGlhVGVrIHNv
dW5kIGNhcmQNCj4gPiA+ID4gZHJpdmVyLg0KPiA+ID4gDQo+ID4gPiBJZiB0aGV5IGFyZSB1c2Vk
LCB3aHkgc3VkZGVubHkgdGhleSBhcmUgbmVlZGVkPyBXaGF0IGNoYW5nZWQ/DQo+ID4gDQo+ID4g
Tm90aGluZyBoYXMgY2hhbmdlZC4gVGhlc2Ugc2hvdWxkIGhhdmUgYmVlbiBhZGRlZCBhbHRvZ2V0
aGVyIHdoZW4NCj4gPiB0aGUNCj4gPiBiaW5kaW5nIHdhcyBmaXJzdCBpbnRyb2R1Y2VkLiBUaGlz
IHBhdGNoIGlzIHRvIGZpbGwgdGhlIGdhcHMgYW5kDQo+ID4gZml4DQo+ID4gZHRic19jaGVjayB3
YXJuaW5ncywgbGlrZSBJIG1lbnRpb25lZCBpbiB0aGUgY292ZXIgbGV0dGVyLg0KPiA+IEkgY2Fu
IGFkZCBhIGxpbmUgaW4gdGhlIGNvbW1pdCBtZXNzYWdlIHNheWluZyBpdCdzIHRvIGZpeCB0aGUN
Cj4gPiB3YXJuaW5nDQo+ID4gaW4gYWRkaXRpb24gdG8gdGhlIGNvdmVyIGxldHRlciwgaWYgdGhh
dCdzIHByZWZlcnJlZC4NCj4gPiANCj4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gU2lnbmVkLW9m
Zi1ieTogRmVpIFNoYW8gPGZzaGFvQGNocm9taXVtLm9yZz4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+
IA0KPiA+ID4gPiAgIC4uLi9iaW5kaW5ncy9zb3VuZC9tZWRpYXRlayxtdDgxODgtbXQ2MzU5Lnlh
bWwgICAgICAgICB8IDEwDQo+ID4gPiA+ICsrKysrKysrKysNCj4gPiA+ID4gICAxIGZpbGUgY2hh
bmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdA0KPiA+
ID4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9tZWRpYXRlayxt
dDgxODgtDQo+ID4gPiA+IG10NjM1OS55YW1sDQo+ID4gPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3NvdW5kL21lZGlhdGVrLG10ODE4OC0NCj4gPiA+ID4gbXQ2MzU5Lnlh
bWwNCj4gPiA+ID4gaW5kZXggZjk0YWQwNzE1ZTMyLi43MDFjZWRmYTM4ZDIgMTAwNjQ0DQo+ID4g
PiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9tZWRpYXRl
ayxtdDgxODgtDQo+ID4gPiA+IG10NjM1OS55YW1sDQo+ID4gPiA+ICsrKyBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9tZWRpYXRlayxtdDgxODgtDQo+ID4gPiA+IG10
NjM1OS55YW1sDQo+ID4gPiA+IEBAIC0yOSw2ICsyOSwxNiBAQCBwcm9wZXJ0aWVzOg0KPiA+ID4g
PiAgICAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9waGFuZGxlDQo+
ID4gPiA+ICAgICAgIGRlc2NyaXB0aW9uOiBUaGUgcGhhbmRsZSBvZiBNVDgxODggQVNvQyBwbGF0
Zm9ybS4NCj4gPiA+ID4gDQo+ID4gPiA+ICsgIG1lZGlhdGVrLGFkc3A6DQo+ID4gPiA+ICsgICAg
JHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhhbmRsZQ0KPiA+ID4gPiAr
ICAgIGRlc2NyaXB0aW9uOiBUaGUgcGhhbmRsZSBvZiBNVDgxODggQURTUCBwbGF0Zm9ybS4NCj4g
PiA+IA0KPiA+ID4gQW5kIHdoYXQgaXMgdGhlIGRpZmZlcmVuY2UgYmV0d2VlbiBBU29DIGFuZCBB
RFNQIHBsYXRmb3Jtcz8gV2hhdA0KPiA+ID4gYXJlDQo+ID4gPiB0aGV5IHVzZWQgZm9yPw0KPiA+
IA0KPiA+IEknbSBub3QgYSBNZWRpYVRlayBvciBhdWRpbyBmb2xrcywgYW5kIEknbSBhZnJhaWQg
dGhhdCBJJ20gbm90IHRoZQ0KPiA+IGJlc3QgcGVyc29uIHRvIGV4cGxhaW4gdGhlIGRldGFpbHMg
YWNjdXJhdGVseSBpbiBmcm9udCBvZiBleHBlcnRzDQo+ID4gb24NCj4gPiB0aGUgbGlzdC4uLiBJ
IGtub3cgaXQncyBhbiBhdWRpbyBEU1AgYnV0IHRoYXQgZXhwbGFpbnMgbm90aGluZy4NCj4gPiBN
ZWRpYVRlayBkaWRuJ3QgcHJvdmlkZSBhIG1lYW5pbmdmdWwgZXhwbGFuYXRpb24gaW4gdGhlIHRy
ZWUgb3INCj4gPiBjb21taXRzLCBhbmQgSSB3YW50IHRvIGF2b2lkIGFkZGluZyBhZGRpdGlvbmFs
IGJ1dCBsaWtlbHkNCj4gPiBtaXNsZWFkaW5nDQo+ID4gZGVzY3JpcHRpb25zIGZyb20gc29tZW9u
ZSB3aG8gZG9lc24ndCBoYXZlIGVub3VnaCBrbm93bGVkZ2UsDQo+ID4gcG90ZW50aWFsbHkgY2F1
c2luZyBldmVuIG1vcmUgY29uZnVzaW5nIHNpdHVhdGlvbnMgaW4gdGhlIGZ1dHVyZS4NCj4gPiBQ
bHVzLCB0aGUgc2FtZSBjaGFuZ2VzIHdlcmUgYWNjZXB0ZWQgYXMtaXMgaW4gdGhlIHBhc3QsIHNv
IEkNCj4gPiBhc3N1bWVkDQo+ID4gdGhleSBtaWdodCBiZSBzZWxmLWV4cGxhbmF0b3J5IHRvIHBl
b3BsZSB3aG8gYXJlIGZhbWlsaWFyIHdpdGggdGhlDQo+ID4gbWF0dGVyLg0KPiA+IA0KPiANCj4g
VGhlIEF1ZGlvIERTUCBpcyBhIFRlbnNpbGljYSBIaUZpLTUgRFNQLCBhbmQgaXQncyBhIGJsb2Nr
IHRoYXQgaXMgLQ0KPiBoYXJkd2FyZQ0KPiBzcGVha2luZyAtIHNlcGFyYXRlZCBmcm9tIHRoZSBy
ZXN0IG9mIHRoZSBBdWRpbyBpbnRlcmZhY2VzIG9mIHRoZQ0KPiBTb0MuDQo+IA0KPiBUaGUgd2hv
bGUgc291bmQgc3Vic3lzdGVtIGNhbiB3b3JrIGVpdGhlciB3aXRoIG9yIHdpdGhvdXQgdGhlIERT
UCwgaW4NCj4gdGhlIHNlbnNlDQo+IHRoYXQgdGhlIERTUCBpdHNlbGYgY2FuIHJlbWFpbiB1bnBv
d2VyZWQgYW5kIGNvbXBsZXRlbHkgdW5jb25maWd1cmVkDQo+IGlmIGl0cw0KPiBmdW5jdGlvbmFs
aXR5IGlzIG5vdCBkZXNpcmVkIC0gaGVuY2UsIHRoaXMgaXMgYSBib2FyZCBzcGVjaWZpYw0KPiBj
b25maWd1cmF0aW9uOg0KPiBpZiB0aGUgYm9hcmQgd2FudHMgdG8gdXNlIHRoZSBEU1AsIHdlIHVz
ZSB0aGUgRFNQIC0gb3RoZXJ3aXNlLCB3ZQ0KPiBqdXN0IGRvbid0Lg0KPiANCj4gUmVnYXJkaW5n
IHRoZSB0d28gInBsYXRmb3JtcyIsIGluIHNob3J0Og0KPiAibWVkaWF0ZWsscGxhdGZvcm0iIC0+
IEF1ZGlvIEZyb250IEVuZCAoQUZFKQ0KPiAibWVkaWF0ZWssYWRzcCIgLT4gQXVkaW8gRFNQDQo+
IA0KPiBOb3csIHlvdSBjYW4gZWl0aGVyIGxpbmsgdGhlIEFGRSBEQUlzIHRvIHRoZSBJMlMNCj4g
DQo+IEFzIGZvciAibWVkaWF0ZWsscGxhdGZvcm0iIC0gdGhhdCdzIHVzZWQgdG8gbGluayB0aGUg
QW5hbG9nIEZyb250IEVuZA0KPiAoQUZFKSBhcw0KPiB0aGUgREFJIExpbmsgcGxhdGZvcm0gKHNv
IHRoZSBwYXRoIGlzIGRpcmVjdCB0by9mcm9tIERML1VMIERBSXMgdG8NCj4gQUZFKSBvciB0aGUN
Cj4gQURTUCBvbmUgYXMgdGhlIERBSSBMaW5rIHBsYXRmb3JtIChzbyB0aGF0IHRoZSBwYXRoIGlz
IHRvL2Zyb20gREwvVUwNCj4gREFJcyB0bw0KPiBEU1AgdG8gQUZFKSwgYnV0IHRoYXQgLSBvZiBj
b3Vyc2UgLSBzdGlsbCByZXF1aXJlcyBhbiBBRkUsIG90aGVyd2lzZQ0KPiB5b3UgY2Fubm90DQo+
IGdldCB0aGUgYXVkaW8gb3V0IG9mIHRoZSBzcGVha2VycyBvciBpbiBmcm9tIHRoZSBtaWMgYW55
d2F5Lg0KPiANCj4gPiA+IA0KPiA+ID4gPiArDQo+ID4gPiA+ICsgIG1lZGlhdGVrLGRhaS1saW5r
Og0KPiA+ID4gPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3N0
cmluZy1hcnJheQ0KPiA+ID4gPiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ID4gPiArICAgICAgQSBs
aXN0IG9mIHRoZSBkZXNpcmVkIGRhaS1saW5rcyBpbiB0aGUgc291bmQgY2FyZC4gRWFjaA0KPiA+
ID4gPiBlbnRyeSBpcyBhDQo+ID4gPiA+ICsgICAgICBuYW1lIGRlZmluZWQgaW4gdGhlIG1hY2hp
bmUgZHJpdmVyLg0KPiA+ID4gDQo+ID4gPiBUaGUgbGlzdCBpcyBwcm92aWRlZCBiZWxvdy4gSSBk
b24ndCB1bmRlcnN0YW5kIHdoeSBkbyB5b3UgbmVlZA0KPiA+ID4gaXQuIFlvdXINCj4gPiA+IG1z
ZyBpcyBwcmV0dHkgdXNlbGVzcyAtIHlvdSBkZXNjcmliZSB3aGF0IHlvdSBkbywgaW5zdGVhZCBv
ZiB3aHkuDQo+ID4gDQo+ID4gSSB0aGluayB0aGlzIGlzIHVzZWQgdG8gZXhwbGljaXRseSBsaXN0
IHRoZSBpbnRlcm1lZGlhdGUgYnV0IGhpZGRlbg0KPiA+IERBSXMsIGJ1dCBhZ2FpbiwgdGhlcmUn
cyBub3QgbXVjaCBpbmZvIGFib3V0IHRoZW0gdW5sZXNzIE1lZGlhVGVrDQo+ID4gY2FuDQo+ID4g
ZXhwbGFpbiBtb3JlIGRldGFpbHMgYW5kIHdoeSB0aGV5IG5lZWQgYSB2ZW5kb3IgcHJvcGVydHkg
Zm9yIHRoaXMuDQo+ID4gDQo+IA0KPiBZZXMsIHRoaXMgaXMgdXNlZCBmb3IgZXhhY3RseSB0aGF0
Li4uIGJ1dCBJIGJlbGlldmUgdGhhdCB3ZSBjYW4NCj4gZGVwcmVjYXRlIHRoaXMNCj4gbm93IHRo
YXQgd2UgaGF2ZSBzdXBwb3J0IGZvciB0aGUgInN0YW5kYXJkIiBgYXVkaW8tcm91dGluZ2AgcHJv
cGVydHkNCj4gYW5kIGZvciB0aGUNCj4gREFJIExpbmsgbm9kZXMgKGV4YW1wbGVzIHRoYXQgeW91
IGNhbiBmaW5kIGluIGN1cnJlbnQgZGV2aWNlIHRyZWVzDQo+IGFyZSBtbS1kYWktbGluaywNCj4g
aHMtcGxheWJhY2stZGFpLWxpbmssIG9yIGFueSBvdGhlciBzdWJub2RlIG9mIHRoZSBzb3VuZCBj
YXJkKS4NCj4gDQo+IFNwZWNpZmljYWxseSwgdGhvc2Ugc3Vibm9kZXMgKmRvKiByZXF1aXJlIGEg
ImxpbmstbmFtZSIgcHJvcGVydHksDQo+IHdoaWNoICpkb2VzKg0KPiBlZmZlY3RpdmVseSBjb250
YWluIHRoZSBzYW1lIERBSSBMaW5rIG5hbWVzIGFzIHRoZSBvbmVzIHRoYXQgYXJlDQo+IGluc2lk
ZSBvZiB0aGUNCj4gIm1lZGlhdGVrLGRhaS1saW5rIiBwcm9wZXJ0eS4NCj4gDQo+IE9uIE1UODE5
NSwgeW91IGNhbiBmaW5kIGJvdGggdGhlIHN1Ym5vZGVzIGFuZCB0aGUgbWVkaWF0ZWssZGFpLWxp
bmsgLQ0KPiB5ZXMgLSBidXQNCj4gdGhhdCB3YXMgZG9uZSB0byByZXRhaW4gY29tcGF0aWJpbGl0
eSBvZiB0aGUgZGV2aWNlIHRyZWUgd2l0aCBvbGQNCj4gZHJpdmVycyAoc28sDQo+IGFuIHVudXN1
YWwgY2FzZSBvZiBuZXcgZGV2aWNlIHRyZWUgb24gb2xkIGtlcm5lbCkuDQo+IA0KPiBGaW5hbGx5
LCBJIGJlbGlldmUgdGhhdCB3ZSBjYW4gYXZvaWQgYWRkaW5nIHRoYXQgIm1lZGlhdGVrLGRhaS1s
aW5rIg0KPiBwcm9wZXJ0eQ0KPiB0byB0aGUgTVQ4MTg4IGJpbmRpbmcsIGFuZCByZWx5IG9uOg0K
PiAgIDEuIFdoYXRldmVyIGlzIHByb3ZpZGVkIGluIHN0cnVjdCBzbmRfc29jX2NhcmQgZm9yIHRo
YXQgZGV2aWNlOyBhbmQNCj4gICAyLiBXaGF0ZXZlciBpcyBwcm92aWRlZCBpbiBkZXZpY2UgdHJl
ZXMgYXMgZGFpIGxpbmsgc3Vibm9kZXMsIHdoaWNoDQo+IHdvdWxkDQo+ICAgICAgcmVzdHJpY3Qg
Ti4xIGFzIHRoYXQncyBhbnl3YXkgZGVzY3JpYmluZyBjYXJkIHByZWxpbmtzLg0KPiANCg0KVGhl
ICJtZWRpYXRlayxkYWktbGluayIgcHJvcGVydHkgaXMgdXRpbGl6ZWQgdG8gaGlkZSB0aGUgdW51
c2VkIGRhaS0NCmxpbmtzIGluIHRoZSBzb3VuZCBjYXJkLiBCeSBoaWRpbmcgdGhlIHVudXNlZCBG
RSBsaW5rcywgaXQgY2FuIHNhdmUgdGhlDQpuZWNlc3NhcnkgbWVtb3J5IGFuZCBwcmV2ZW50IGNv
bmZsaWN0cyB3aGVyZSBib3RoIHRoZSBEU1AgYW5kIEFQDQpjb250cm9sIHRoZSBzYW1lIEFGRSBN
ZW1pZnMuDQoNClRoaXMgY29uY2VwdCB3YXMgZmlyc3QgaW1wbGVtZW50ZWQgaW4gbXQ4MTk1IGFz
IE1hcmsgYWltZWQgdG8gYXZvaWQgdGhlDQpuZWVkIGZvciBhIHNlcGFyYXRlIGRyaXZlciBmb3Ig
ZGlmZmVyZW50IHN5c3RlbSBjb25maWd1cmF0aW9ucy4NCldpdGggdGhlIGludHJvZHVjdGlvbiBv
ZiBEU1AgKFNPRiksIGlmIGNlcnRhaW4gQUZFIE1lbWlmcyBhcmUgYWxyZWFkeQ0KaW4gdXNlIGlu
IHRoZSBEU1Agcm91dGUsIHRoZXkgc2hvdWxkIGJlIGV4Y2x1ZGVkIGZyb20gdGhlIFBDTSBub2Rl
cw0KY3JlYXRlZCBmb3IgdGhlIEFGRSBwbGF0Zm9ybS4NCg0KQXQgdGhhdCB0aW1lLCB3ZSBkaWQg
bm90IGhhdmUgYSBiZXR0ZXIgd2F5IHRvIGhhbmRsZSB0aGVzZSBzY2VuYXJpb3MsDQpzbyB3ZSBt
YWRlIHVzZSBvZiBhIHZlbmRvci1kZWZpbmVkIHByb3BlcnR5Lg0KDQpJdCBoYXMgYmVlbiBhIHdo
aWxlIHNpbmNlIEkgbGFzdCBrZXB0IHVwIHdpdGggdGhlIHVwZGF0ZXMgaW4gbXQ4MTg4LCBzbw0K
SSdtIHVuY2VydGFpbiBpZiB0aGUgY3VycmVudCBtZWNoYW5pc20gZm9yIHNvdW5kIGNhcmQgZGVz
Y3JpcHRpb24gaXMNCnN1ZmZpY2llbnQgZm9yIGhhbmRsaW5nIHN1Y2ggc2NlbmFyaW9zLiBJZiBp
dCBpcywgSSBhZ3JlZSB0aGF0IHdlIGNhbg0KZGVwcmVjYXRlIHN1Y2ggYSB2ZW5kb3IgcHJvcGVy
dHkgZnJvbSBtdDgxODguDQoNClRoYW5rcywNClRyZXZvcg0KDQoNCj4gQ2hlZXJzLA0KPiBBbmdl
bG8NCj4gDQo+ID4gUmVnYXJkcywNCj4gPiBGZWkNCj4gPiANCj4gPiA+IA0KPiA+ID4gQmVzdCBy
ZWdhcmRzLA0KPiA+ID4gS3J6eXN6dG9mDQo+ID4gPiANCj4gDQo+IA0K

