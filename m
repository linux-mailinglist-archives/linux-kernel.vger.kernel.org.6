Return-Path: <linux-kernel+bounces-239871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA353926648
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29AE4B2197F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B150A18306D;
	Wed,  3 Jul 2024 16:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Kbjmi5kW";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="SuRcOw2X"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7C8282E1
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 16:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720024913; cv=fail; b=h7alF9P+t2VaD8kJzJ86TQApmQ7Lz2xboXjdzQCRO2rs2uqhPDm6kqWz8fagclsX0Th/p12fED5vlc+MAWRcOnSX9Tr3hMklRUL1pKsKafSoC+DKfrbwPju6Kq9Y1SYLFe79wPue7N0J0Awrujk83mAJbIEF+f8ffgkqOt+ysSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720024913; c=relaxed/simple;
	bh=mMDNZYBrJllCSFdCveFiHKPiVbAwReAEa67QcG1y6bQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i2Apzs17oNjhlrckvFD1J4cffpTCljYr6ADhOkE5XghQCCdJ2uUDmnxshkXd87nJwa2EZRiMRKOFEhEp7MOyMLpMhuboGrQm40B/yy9aoFZZuZ5dTrbv5USxiN5RYouTqHhZrd07ruDyBXKEZKQ8ivktsfvW6mMTZPABuIhqV1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Kbjmi5kW; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=SuRcOw2X; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 23a66ece395b11ef99dc3f8fac2c3230-20240704
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=mMDNZYBrJllCSFdCveFiHKPiVbAwReAEa67QcG1y6bQ=;
	b=Kbjmi5kW/zqSFWsLX2G8+1dWGayNU04a2QVIRDGDqW9LRmi3YWABS5a2DlJOMwc/L1WltyATbXHJqfOBUXMqDxYlESSWsjDBqvzNvRSOy7zTqyQPUy2I8G+pm1SJ3LdjcqPfFjeXLycCjGtkyIk8Ym/bO6ULVA5UnJqJG4iO6SE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:a752cd0b-3ad6-4f90-bf2e-418c49550c2b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:1cc0de44-a117-4f46-a956-71ffeac67bfa,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 23a66ece395b11ef99dc3f8fac2c3230-20240704
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1497016078; Thu, 04 Jul 2024 00:41:47 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 4 Jul 2024 00:41:46 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 4 Jul 2024 00:41:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4nqib/D03lfQB4cr7GLmxZJxMMRpRpZiI+JpF3O9VIc+bv/zyLWPgoJEy1vHtk7DMH14mwiaA2FXvLxERQ+YAAj3N//WljhiIHhFmxakEwEpoJlgHYCkjrxeqoENQaFprPyDMuV83JYO1Xa6uFt19PyjAiNY5vkHpMcLQBEWVtqgVwtVmb+z0T9tI57yN91PV2QEHcWdLlj/h9MTuogBj5zF8dXACvNGeFGrJTO52ASMUgJKY6JpqKEoaZsoZBdXeSN/6VMvB1yGJxXDtcTxv2RZBC7TNwjH+m0tOsiVIaM3E+5Pf+1MUmsGnTCojING8c8PWEGQhwi6fXxkKNWsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMDNZYBrJllCSFdCveFiHKPiVbAwReAEa67QcG1y6bQ=;
 b=RxLhl1b8KzT678LBw9ozy1hFZPEiol3OcosbCPItQGLYK6ZVOeF6CYO4uVXDLLeUxWy31tV3wr6teIiFdlQ1cpUaJWj7Jv4lbRsuwTXmU6m4INyJVKF09HjRzQ19Uv238G0mqZMUtMvpp4Q9afeV4epOq+rqQ8u/Q/LRuiZDELg/eyRjzwR2uu9yO2IFJuwPeUVgKHYjXpLQ9cb9RG4bxjueW+S3hjpJKSEbNoYFmF+silBlOe6aFzJgGO891uqFxOuvDc+tY87hqWZsR2r2/Yarq7rGEH40J/NfX7xKKzcSSSKpfV39MCUez6xhA3DveZBwNvk8n4P2mfoHg3ML/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMDNZYBrJllCSFdCveFiHKPiVbAwReAEa67QcG1y6bQ=;
 b=SuRcOw2XsB2iHLei0nCviWX0WcZqAj0JuhX3od6UYvm+NXwm7a2nwWreT8WHmjH4SU3n8dXvrpCA0OZ5CxfXhOyniqeF8xNEh6a+2DJP2IUDySXrTRRCh2UKGpz7KZuNocfPm30K9M66aCepE/J2JXSLVZvciumHJMk9Ei1yWok=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TY0PR03MB6498.apcprd03.prod.outlook.com (2603:1096:400:1bd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.34; Wed, 3 Jul
 2024 16:41:42 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%5]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 16:41:41 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 2/2] mailbox: mtk-cmdq: Move pm_runimte_get and put to
 mbox_chan_ops API
Thread-Topic: [PATCH 2/2] mailbox: mtk-cmdq: Move pm_runimte_get and put to
 mbox_chan_ops API
Thread-Index: AQHavg+NdbRKcT+3skGSUl4IqMicy7HMSVSAgADxdQCAAHoqAIABEY4AgAB6xoCAAPnzgIAAh/UAgAYULICAAGkzgIAApk4AgAALTYCAAek2AIACwj0AgAi2BgA=
Date: Wed, 3 Jul 2024 16:41:41 +0000
Message-ID: <092d917b4cae2762317a8739c874855554ae913f.camel@mediatek.com>
References: <20240614040133.24967-1-jason-jh.lin@mediatek.com>
	 <20240614040133.24967-3-jason-jh.lin@mediatek.com>
	 <CABb+yY2bwj2BcdJLGe1ZYwCrnXL3LtcePMb=wQPaBKorBSs2yA@mail.gmail.com>
	 <fc92d51cc6e55301c081ea2d589e1ba6cdd295ee.camel@mediatek.com>
	 <CABb+yY1L+YGjf6O9UgPYkS2gWAdo=7QoojSAUNWC_8o7XtZQSg@mail.gmail.com>
	 <1f815ff8-2b7a-48de-8b47-0bc9b3cb67ab@collabora.com>
	 <CABb+yY1Yy8o3ofAiC-uV+gDrO3QDTWz3_XTUMai_2uyrnj-VrQ@mail.gmail.com>
	 <b7ebc021d391452eaf2149976ea2d53fba3d89fc.camel@mediatek.com>
	 <CABb+yY3+pnuXDK_jZMDYOAzahdSZ5iig51VqzM=FFHrFpK+9LA@mail.gmail.com>
	 <4e5d4362-4940-4ba0-95aa-627b82e21e41@collabora.com>
	 <CABb+yY3eXvJRUq7MOqB8QZ9N4aiuogaUCTfP7MerKdNbAbLkvw@mail.gmail.com>
	 <895af04e45d286c38d01f48b29ad41598b7dadb7.camel@mediatek.com>
	 <CABb+yY1EZOsKUR7WUX0Ni0Ukbqz0+yRHswiu07tNXtY1A1gNUQ@mail.gmail.com>
	 <d6f0e7072ec0e89e573e5720fb2b9c621eb9154c.camel@mediatek.com>
	 <CABb+yY0+fFw7Bg578DFEdrigVFgf4-v3qo2JVruEa3ExtvRsMg@mail.gmail.com>
In-Reply-To: <CABb+yY0+fFw7Bg578DFEdrigVFgf4-v3qo2JVruEa3ExtvRsMg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TY0PR03MB6498:EE_
x-ms-office365-filtering-correlation-id: ffd6bf5d-1b8a-469c-4f02-08dc9b7f0457
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OEJ0amRIWWNBbVVnQ1JWRmZIVzYvOEp2RXdwSmZOa29DakIwSTZqUWlObFp4?=
 =?utf-8?B?UEw3eWR3bzJ3NXBHUEptU3QvdkZaTldzb25zRi9IMVFoTG5DV0RzTmhvbFM4?=
 =?utf-8?B?UWcwMWtjU0t5UHJhU2dyWHYxSnhFTmdXOW5qbjRlc2dOOFppdTBabCtMWW5m?=
 =?utf-8?B?ZHc3ZmFBc0RLTUNqdDlUSzJnbG4wZUY0VWEvWVFmM3hxdDdKRVc2bVF3aWxv?=
 =?utf-8?B?dkhON1BSY3krcmpZK2lTaWhnemhjTE5jN2pzMjd3MitDeEpaZTgzS0xDS2lq?=
 =?utf-8?B?eUx3aVNGeEYyWW9lU3RCSGI1VXZpUnF2NXBCcXVCTGIwcUN6ajRtRERLU0hn?=
 =?utf-8?B?Q1JBT214SmpURUdTaE1yMDdGNGpOVVBxRDdGNHcwSmw2QVJ2SlA4RlhPMzFF?=
 =?utf-8?B?U1J5dnhFRCtKQmMyelFNN3lGdHdIYmVDemlQZFZuTWxqQ1RFUXN2Mmp3SjJ5?=
 =?utf-8?B?OUttRGVtYjhLUHQwd0NOQVlJKzh4NnhMR28yazBpZy9US3FJb0J4dEp0elRm?=
 =?utf-8?B?UDE4VitOM053dDZ3dDlDWm54UkFTaUhtRGd2NHR2VE1rMmtXZS90MXdOQXhS?=
 =?utf-8?B?RzhRUGt5bFdDaS9JUFpaTmNqdklqUGxLdnQzOE9wL2hpcWpjaTdTcThBSWJS?=
 =?utf-8?B?LzJ2WWFvSG5hNXoxN3NSQUFTUFJmVENQSTNsYXp3MFdaY3RGOFMxN05qU0lI?=
 =?utf-8?B?QXVua2U2MUYrdmxlL090Um8vL0hIREhDWUNmWlIxWC9GV1hRZFEwVnNJNzIw?=
 =?utf-8?B?RzNRMWtQb2N1N1lFMmZMRDlMcG95NmhkRStOZHRnRS92S2NqWDBCNFNObjZa?=
 =?utf-8?B?Ni9KMFBoN3Qyb09HMzRBakhNK284dDBBT21nU0hCQUVZRVptL0Zpem9aQUZI?=
 =?utf-8?B?dnlJYVBod0JIWHYvd0tsQnF2bE1WSXAyWGpUUllUdU9qZzcyeDVFVFFCZ2Rs?=
 =?utf-8?B?QUF6VVVyZkZTdGxJM2lqUDh2RmczODNkM1Z0NmZIN1ozcHY3a2RyK2JHNW5J?=
 =?utf-8?B?T015cUYyaUVvYXRFbXh6NkVlV3RHVGptN2owbjRUbWhkd3FPWUhQdENpcjFV?=
 =?utf-8?B?KzgzTzViMHZKRmg5R2RHNFY3NkdzanhocGV4L21iTzVXU00ycFNmZkpHb0Zw?=
 =?utf-8?B?cDY0cldCOGJoSElZMUI3aDBvTHdqWTRVaVYrZldlcEVnN0JBNElodnJxTEhh?=
 =?utf-8?B?aElRZjVWSHBNNnpkNUNWSFBnQmRpWEpVUmdwaC9LdmxGYTZNSnZtS1hxTTdj?=
 =?utf-8?B?dEt1YStQTXlPc3VWWlcxUmc3cStVUjI3ZkJseHFyeTRqTXByQ2Q3OXB0dDVr?=
 =?utf-8?B?RUw1TTR3bUp3bENkdnlJako1bU1HWEtNaXFhRFhqRXNIOFhjZXZUV2lVZWxj?=
 =?utf-8?B?L3RQd0R5SklVa0xCRDA2SXF5K0VpUDU3c1NyV05TWWZqKzNrZmg3U0hwSHQ0?=
 =?utf-8?B?a3VyTmt0UlQxSDlGaFFmMk42ZTZEdFRSWnF5czZCN3B4SG1HVE00MWdjNWQ5?=
 =?utf-8?B?SER0VG8rUnRXQUpKMHZuTnVIV3UyS0VGVWwvaUdSN1pOUXY1VXp6OFRtaDdI?=
 =?utf-8?B?bDhYN01IaEtzbmdiU1hTNms0aTZvZ1pCbmhreGFwUG0ydFp2NTVRMGdXZTc5?=
 =?utf-8?B?UWRDYk1RcjBqTmYzQXRHbEY2ckNVb3U4Ukx1Nll3ZnIvTUVzdk1oeG9yUzg3?=
 =?utf-8?B?Z2dhblZOQ2FDU1BBRHZyMHFwUTcvcWZuUnNJUFV6TDhybS9udDhRSXdzMU4w?=
 =?utf-8?B?Uk5lY3c5S2pma1B0N2lqQUplLzY3MFZwSkJVTGJYa3ZGeEFlMG4vTzYyYzBH?=
 =?utf-8?B?VnFkQUFxRUdWV3M4YTRFTUZ2QnVUam1iZnA4OVEvTElaZ0lEcjBLRzdyOUph?=
 =?utf-8?B?blU0TVhvemxPWHRTdHNURHovVHhzaXJobGFWbVg1VUFFS0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWV2RUZ1YmpFUHJzcCtjcVhMaTJVMS9iblByTFlPb0s0MUJld1QvNzlLMzhj?=
 =?utf-8?B?dG41RjZLT0NWTS9WRXE2SlE3QjVPVlFSbnJiZitTQXJjYUNwN0M3MFFaL2R5?=
 =?utf-8?B?UXlYRkliSWF3MFEyNUJQenlMdUltZk8vaFZ1aFNnS0RkNGpKQ1RqZkJoWVQ2?=
 =?utf-8?B?Ly9nMWk0VWJkK3FmMGZBZktNV0VsSExDV3pXeXJESi91ckFTWFF2dWJkdk9a?=
 =?utf-8?B?dE04Vmk0TDlWYlZTdE9IbGU4bjNGSkFVTWQ3YkxxdWRMd1A4ZW9SOHZFUHJO?=
 =?utf-8?B?VGYyU01MUE56TmRmcTJTUnZrc1hrbWprVXhHanNMclFzaGVhcjBaN0hqblZT?=
 =?utf-8?B?ejBJUVNYaXRSWjZhd0s0cFdCaFFsSTNHeWM4Sm4weTlwdHdxYmh6NEJRT3ow?=
 =?utf-8?B?SlJlam4xbytZUFpCTkQ5TWZHOEFHMzVkdmY1TUluRUVWWWpEYW82UEFqZ0Jy?=
 =?utf-8?B?Qk0vdlY0SXpLUnJjNDhpU2FwZ1Y1TzNZYWloTVJ3RXpHOEFVWEhRcGFvSmZ2?=
 =?utf-8?B?VGhveGQ2aWRsOHJHaDB6M2E1VEFuSTBJaWlwOUtmT0lhQnh4SjczN1Q4aDFI?=
 =?utf-8?B?TDBaSm5NWHAzQjBpWEVmRk1keHZEMjdHbkRjUGs4bk5sTDVpKzdlNHZQSnFY?=
 =?utf-8?B?MDN4ZTNQSzRLaDZIUVVLRmxZSzAwb3VRYUZlZm9pYlhKaUd4YWZxdVpZdU9B?=
 =?utf-8?B?aXI4VmZDVCtickc4Sm5SL3VFb2tScmkrUmx3SzdDbXBIUEFhb0xuSmtWdVlE?=
 =?utf-8?B?U3gybnk1U0REQUc0TUtjK3pSWnBDODBDVjh4ZWdXVE9PYkRENWxIL0N1VHJ1?=
 =?utf-8?B?Zk12ZzUyOWdHYStMSUlWUnlJRlRkME1XcEZFYW9GMlIxOGdGSURUaXUrdzZZ?=
 =?utf-8?B?WGhJdE1CbnkwcEREWEJETFdEZ3cyTHJteGFhZW5rTXVtRUk2Wldpci84c1oy?=
 =?utf-8?B?b2E0L3dqazhyU3AwdDBLTEVnSnNTVHFIZUtFRVEyaDcyOWpwcTViaUY2RnZD?=
 =?utf-8?B?NFFkcUJBNitjOWtQV2VBaSthN1NWMEx0Vi9ZYVNsam12cSs3cGlNUFlQcHFM?=
 =?utf-8?B?L0xxZTBIY3R0eUhzVzR0TXlUUlFsWTJYSlRraXZmOTVicU1MSm0za2xGeTl3?=
 =?utf-8?B?eW45UVQwTm4vV3lpV1hzeXVlSjRqZjNoOTVRTGZUME9iWW9obWQ2dUdqSVdo?=
 =?utf-8?B?b0RhZ24rZWlSQUFsZldhQ1hxSSs3bldNbWk5enRNbzZZRjJqT1NrOVF0elJQ?=
 =?utf-8?B?Wk1xMWlGY05jZWprQmtQNHdiWVVuMDFTVlI5eHBnclh5dUxMSmlNOWYycnJQ?=
 =?utf-8?B?WWp0a2xIMFVNS29QMlM3QVFZeVdMTXZLT3hrTXc0NGppRzhkQkl4TXdiKzl4?=
 =?utf-8?B?MnFGN0UxbndTdG5VOCtydXlrNEI1MjY2dWNKZERra21FMHJQRW9JaDNZYytP?=
 =?utf-8?B?SFc2djJ0ZFJQU3EwVFZ1bm9JQmhKK05DUkJnM2xUd21uYW93MVBoSFNVbER3?=
 =?utf-8?B?V1ZSaEk2WEdEODgxNnlKcGRpQ0dna2tONmsranhmMG9Oa0Flc0NBdFVwUlJo?=
 =?utf-8?B?Z0xhWmxmeDhadm1vSTJjcFRMVVRQNTZsd2M2bVVOaXRXTXJIQmR5d1FWZmdp?=
 =?utf-8?B?MGNDdGFKVGZIdTU0RlRySENiN3Q0RTZhNHo4ZHhhY29yaWpaMC9tdHNtSXRI?=
 =?utf-8?B?OEFQN3ZOaFhRVnBEUzVNKzBncDF0RERabU04RXJNeTBLR21BcDlIZ1BTb2hC?=
 =?utf-8?B?OUZBZHlUMnkxUjg5d3hJN25mRHFUaXlLVEs2dWNFeThpWVRnTkQxSG53QW5Q?=
 =?utf-8?B?aEFjYUxtZnJKdXhVVWluQjhRNVMvVXFUZnNYN0NLV3F4a2FaUmFBMnJIeHpZ?=
 =?utf-8?B?N1ZacFVVZkpFOUpIcU0rY0J1MlNud0dOZVJmUDFWRFlUMFN1Y0VrSDNzelpt?=
 =?utf-8?B?UkNPNHdDdHZKOExCL3J5eVRuOVRNUWhhODF0dy9xeFR3K280RzlQNWl5U3Vw?=
 =?utf-8?B?Tzh4dUl3dENXUHdIKzhla3hBRHlOWXhhVzFJOElmaHVRVXh1Nm44TVlnVkZY?=
 =?utf-8?B?a0E2eVZzb2xJaGhhSVMxT29NVi9YR1JwVWlOVUsxK0paM3dFUVY2azl1Z2ts?=
 =?utf-8?B?RlF4a2RxTEJLdGNIUXl4OVhlMGdxQXlISDRHWkUycGJucE5QdXRJREowbjcx?=
 =?utf-8?B?alE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <437A7AD14DCFC34EA3A54E4F0AA27A67@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd6bf5d-1b8a-469c-4f02-08dc9b7f0457
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 16:41:41.5668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HH5/WwdSpFneA+mO5q7EGHZ4KCcA/GsH7InSy/MgpWLvw6WGbD8WaU5AHn1c04S//r2D6X3fIcK7JSG9RbN97+3OrlVugaixpUWoTAOqviQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6498

T24gVGh1LCAyMDI0LTA2LTI3IGF0IDIyOjQwIC0wNTAwLCBKYXNzaSBCcmFyIHdyb3RlOg0KPiAg
CSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUg
Y29udGVudC4NCj4gIE9uIFdlZCwgSnVuIDI2LCAyMDI0IGF0IDQ6MzLigK9BTSBKYXNvbi1KSCBM
aW4gKOael+edv+elpSkNCj4gPEphc29uLUpILkxpbkBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+
ID4NCj4gPiA+IFRoZSBpZGVhIGlzIHRoYXQNCj4gPiA+IDEpIElmIHRoZSBnYXAgYmV0d2VlbiB0
cmFuc2ZlcnMgb24gYSBidXN5IGNoYW5uZWwgaXMgfjEwbXMgb3INCj4gPiA+IG1vcmUuICBBbmQg
Li4NCj4gPiA+IDIpIFRoZSBzaWxlbmNlIG9uIHRoZSBtYWlsYm94IGNoYW5uZWwgaXMgbXVsdGlw
bGUgb2YgMTAwbXMuIEFuZA0KPiAuLi4NCj4gPg0KPiA+IFRoZSBtYWlsYm94IGNoYW5uZWwgd291
bGQgbm90IGJlIGFsd2F5cyBidXN5IGFuZCB0aGUgZ2FwIGlzIG5vdA0KPiA+IGNvbnNpc3RlbnQg
YXMgd2VsbC4NCj4gPiBGb3IgZXhhbXBsZSwgZGlzcGxheSBkcml2ZXIgY2FsbHMgbWJveF9zZW5k
X21lc3NhZ2UoKSBldmVyeSB+MTZtcw0KPiB3aGlsZQ0KPiA+IFVJIGlzIHVwZGF0aW5nIGluIDYw
ZnBzLg0KPiA+IElmIFVJIGRvc2Ugbm90IHVwZGF0ZSwgZGlzcGxheSBkcml2ZXIgd29uJ3QgY2Fs
bA0KPiBtYm94X3NlbmRfbWVzc2FnZSgpLA0KPiA+IHNvIHVzZXIgbWF5IG5vdCBoYXMgdGhlIGdh
cCBhbmQgdGhlIHNpbGVuY2UgbGlrZSB0aGlzLg0KPiA+DQo+IEZyb20geW91ciBsb2dzLCBzZW5k
X2RpZmYgb25seSBpbmNyZWFzZXMgZnJvbSAxNm1zIGlmIHRoZSBVSSBpcyBub3QNCj4gdXBkYXRp
bmcuIFdoaWNoIG1ha2VzIGl0IG1vcmUgcHJ1ZGVudCB0byByZWxlYXNlIHRoZSBjaGFubmVsLg0K
PiANCj4gVGhlIHVzZXIgbmVlZHMgdGhlIGNoYW5uZWwgZm9yIG1ib3hfc2VuZF9tZXNzYWdlLCB3
aGlsZSBhY3R1YWwgcG93ZXINCj4gc2F2aW5nIGNvbWVzIGZyb20gY21kcV9ydW50aW1lX3N1c3Bl
bmQvcmVzdW1lLg0KPiBTbyBmb3IgeW91ciB0YXJnZXQgdXNhZ2UgcGF0dGVybiwgdHJhY2UgbWJv
eF9zZW5kX21lc3NhZ2UoKSAsDQo+IGNtZHFfcnVudGltZV9yZXN1bWUoKSBhbmQgY21kcV9ydW50
aW1lX3N1c3BlbmQoKSBhbmQgY29tcGFyZSB0aGUNCj4gdGltZXN0YW1wZWQgbG9ncyB3aXRoIGFu
ZCB3aXRob3V0IHRoaXMgcGF0Y2hzZXQuDQo+IA0KW3NuaXBdDQoNCkkgcmVhbGl6ZWQgdGhhdCB3
ZSBoYXZlIDIgY21kcSBkcml2ZXJzOg0KZGlzcGxheSB1c2VzIDEwMzIwMDAwLm1haWxib3ggYW5k
IGltZ3N5cyB1c2VzIDEwMzMwMDAwLm1haWxib3gNCg0KSSBhZGRlZCBkaWZmIGxvZ3MgaW4gY21k
cV9ydW50aW1lX3Jlc3VtZSgpLCBjbWRxX3J1bnRpbWVfc3VzcGVuZCgpDQphbmQgY21kcV9tYm94
X3NlbmRfZGF0YSgpLg0KDQpIZXJlIGlzIHRoZSBsb2cgb2YgMTAzMjAwMDAubWFpbGJveDoNCi8v
IENNRFEgcHJvYmUNClsgICAgNC4yODg0MDhdIG10a19jbWRxIDEwMzIwMDAwLm1haWxib3g6IElS
UT0yNzkrKysrKysrKysrKysrKw0KLy8gU2hvdyBib290IGxvZ28NClsgICAgOS4xNzc3NDFdIGNt
ZHFfcnVudGltZV9yZXN1bWU6IHJlc3VtZV9kaWZmPTkxNzcgbXMNClsgICAgOS42OTgwNDVdIGNt
ZHFfbWJveF9zZW5kX2RhdGE6IHNlbmRfZGlmZj0xNCBtcw0KLy8gU2hvdyBVSSAgICAgDQpbICAg
MTUuNjIwNTI1XSBjbWRxX21ib3hfc2VuZF9kYXRhOiBzZW5kX2RpZmY9NTkyMiBtcw0KWyAgIDE1
LjY1MjA0MV0gY21kcV9tYm94X3NlbmRfZGF0YTogc2VuZF9kaWZmPTMxIG1zDQpbICAgMTUuNjgx
MzA4XSBjbWRxX21ib3hfc2VuZF9kYXRhOiBzZW5kX2RpZmY9MjkgbXMNClsgICAxNi4yNzYwOTBd
IGNtZHFfbWJveF9zZW5kX2RhdGE6IHNlbmRfZGlmZj01OTQgbXMNClsgICAxNi4zNTUyNTZdIGNt
ZHFfbWJveF9zZW5kX2RhdGE6IHNlbmRfZGlmZj03OSBtcw0KLi4uICAgICAgICAgICAgDQpbICAg
MzUuMDEzMzk1XSBjbWRxX21ib3hfc2VuZF9kYXRhOiBzZW5kX2RpZmY9MTYgbXMNClsgICAzNS4w
MzAzMDFdIGNtZHFfbWJveF9zZW5kX2RhdGE6IHNlbmRfZGlmZj0xNiBtcw0KWyAgIDM1LjA0NzAw
Ml0gY21kcV9tYm94X3NlbmRfZGF0YTogc2VuZF9kaWZmPTE2IG1zDQpbICAgMzUuMDY4MzYwXSBj
bWRxX21ib3hfc2VuZF9kYXRhOiBzZW5kX2RpZmY9MjEgbXMNCi8vIE9wZW4gY2FtZXJhIEFQUA0K
WyAgIDM3LjI5MTkzN10gY21kcV9tYm94X3NlbmRfZGF0YTogc2VuZF9kaWZmPTIyMjMgbXMNClsg
ICAzNy44ODQ0MzVdIGNtZHFfbWJveF9zZW5kX2RhdGE6IHNlbmRfZGlmZj01OTIgbXMNClsgICAz
Ny45MDU3MDNdIGNtZHFfbWJveF9zZW5kX2RhdGE6IHNlbmRfZGlmZj0yMSBtcw0KWyAgIDM3Ljky
ODU5OV0gY21kcV9tYm94X3NlbmRfZGF0YTogc2VuZF9kaWZmPTIyIG1zDQouLi4NClsgICA0MS4z
OTY1NzddIGNtZHFfbWJveF9zZW5kX2RhdGE6IHNlbmRfZGlmZj0xNiBtcw0KWyAgIDQxLjQxMzEw
N10gY21kcV9tYm94X3NlbmRfZGF0YTogc2VuZF9kaWZmPTE2IG1zDQpbICAgNDIuNDQwODYyXSBj
bWRxX21ib3hfc2VuZF9kYXRhOiBzZW5kX2RpZmY9MTAyNyBtcw0KWyAgIDQyLjY0NzA0NV0gY21k
cV9tYm94X3NlbmRfZGF0YTogc2VuZF9kaWZmPTIwNiBtcw0KLy8gQ2xvc2UgY2FtZXJhIEFQUA0K
WyAgIDg5Ljk0MDYzMV0gY21kcV9tYm94X3NlbmRfZGF0YTogc2VuZF9kaWZmPTQ3MjkzIG1zDQpb
ICAxMDYuNzA0OTI4XSBjbWRxX21ib3hfc2VuZF9kYXRhOiBzZW5kX2RpZmY9MTY3NjQgbXMNCi4u
Lg0KWyAgMTEzLjEzMDg0MV0gY21kcV9tYm94X3NlbmRfZGF0YTogc2VuZF9kaWZmPTIxMSBtcw0K
Ly8gcHVzaCBwb3dlciBrZXkgdG8gZGlzYWJsZSBwYW5lbA0KWyAgMTEzLjI4MTk5OV0gY21kcV9y
dW50aW1lX3N1c3BlbmQ6IFIvU19kaWZmPTEwNDEwNCBtcw0KLy8gcHVzaCBwb3dlciBrZXkgdG8g
ZW5hYmxlIHBhbmVsDQpbICAxMzEuMjg3MTkwXSBjbWRxX3J1bnRpbWVfcmVzdW1lOiByZXN1bWVf
ZGlmZj0xMjIxMDkgbXMNCg0KDQpIZXJlIGlzIHRoZSBsb2cgb2YgMTAzMzAwMDAubWFpbGJveDoN
Ci8vIENNRFEgcHJvYmUNClsgICAgNC4yOTA0MDRdIG10a19jbWRxIDEwMzMwMDAwLm1haWxib3g6
IElSUT0yODArKysrKysrKysrKysrKw0KLy8gT3BlbiBjYW1lcmEgQVBQDQpbICAgMzYuMTc0ODY3
XSBCVUc6IHNsZWVwaW5nIGZ1bmN0aW9uIGNhbGxlZCBmcm9tIGludmFsaWQgY29udGV4dCBhdA0K
ZHJpdmVycy9iYXNlL3Bvd2VyL3J1bnRpbWUuYzoxMTY0DQpbICAgMzYuMTgzOTQyXSBpbl9hdG9t
aWMoKTogMSwgaXJxc19kaXNhYmxlZCgpOiAxMjgsIG5vbl9ibG9jazogMCwgcGlkOg0KOTUsIG5h
bWU6IGt3b3JrZXIvdTE3OjANClsgICAzNi4xOTIzODNdIHByZWVtcHRfY291bnQ6IDEsIGV4cGVj
dGVkOiAwDQpbICAgMzYuMTk2Mzk1XSBSQ1UgbmVzdCBkZXB0aDogMCwgZXhwZWN0ZWQ6IDANClsg
ICAzNi4yMDA0ODldIElORk86IGxvY2tkZXAgaXMgdHVybmVkIG9mZi4NClsgICAzNi4yMDQ0MDVd
IGlycSBldmVudCBzdGFtcDogMTYNClsgICAzNi4yMzg2MzZdIENQVTogMiBQSUQ6IDk1IENvbW06
IGt3b3JrZXIvdTE3OjAgTm90IHRhaW50ZWQNClsgICAzNi4yNTE1MDhdIEhhcmR3YXJlIG5hbWU6
IEdvb2dsZSBDaXJpIHNrdTAvdW5wcm92aXNpb25lZCBib2FyZCAoRFQpDQpbICAgMzYuMjU3ODY0
XSBXb3JrcXVldWU6IGltZ3N5c19ydW5uZXIgaW1nc3lzX3J1bm5lcl9mdW5jDQpbICAgMzYuMjYz
MTA3XSBDYWxsIHRyYWNlOg0KWyAgIDM2LjI2NTU1NV0gIGR1bXBfYmFja3RyYWNlKzB4MTAwLzB4
MTIwDQpbICAgMzYuMjY5NDAwXSAgc2hvd19zdGFjaysweDIwLzB4MmMNClsgICAzNi4yNzI3MjJd
ICBkdW1wX3N0YWNrX2x2bCsweDg0LzB4YjQNClsgICAzNi4yNzYzOTBdICBkdW1wX3N0YWNrKzB4
MTgvMHg0NA0KWyAgIDM2LjI3OTcwNl0gIF9fbWlnaHRfcmVzY2hlZCsweDIwNC8weDIxNA0KWyAg
IDM2LjI4MzYzMV0gIF9fbWlnaHRfc2xlZXArMHg1MC8weDgwDQpbICAgMzYuMjg3MjA5XSAgX19w
bV9ydW50aW1lX3Jlc3VtZSsweDQ4LzB4YmMNClsgICAzNi4yOTEzMTZdICBjbWRxX21ib3hfc2Vu
ZF9kYXRhKzB4ODQvMHg0M2MNClsgICAzNi4yOTU1MTBdICBtc2dfc3VibWl0KzB4ODQvMHgxMDQN
ClsgICAzNi4yOTg5MTldICBtYm94X3NlbmRfbWVzc2FnZSsweGI4LzB4MTI0DQpbICAgMzYuMzAy
OTM0XSAgaW1nc3lzX2NtZHFfc2VuZHRhc2srMHg2YjAvMHg5OTANClsgICAzNi4zMDczMDBdICBp
bWdzeXNfcnVubmVyX2Z1bmMrMHg0NC8weDc4DQpbICAgMzYuMzExMzE4XSAgcHJvY2Vzc19vbmVf
d29yaysweDI3NC8weDU3NA0KWyAgIDM2LjMxNTMzNl0gIHdvcmtlcl90aHJlYWQrMHgyNDAvMHgz
ZjANClsgICAzNi4zMTkwOTNdICBrdGhyZWFkKzB4ZmMvMHgxMWMNClsgICAzNi4zMjIyNDJdICBy
ZXRfZnJvbV9mb3JrKzB4MTAvMHgyMA0KWyAgIDM2LjMyNTk4OV0gY21kcV9ydW50aW1lX3Jlc3Vt
ZTogcmVzdW1lX2RpZmY9MzYzMjUgbXMNClsgICAzNi4zNDIyMzVdIGNtZHFfbWJveF9zZW5kX2Rh
dGE6IHNlbmRfZGlmZj0xNjcgbXMNClsgICAzNi4zNjY3MTRdIGNtZHFfbWJveF9zZW5kX2RhdGE6
IHNlbmRfZGlmZj0yNCBtcw0KWyAgIDM2LjM4Mjg4Ml0gY21kcV9tYm94X3NlbmRfZGF0YTogc2Vu
ZF9kaWZmPTE2IG1zDQpbICAgMzYuMzk5NTEyXSBjbWRxX21ib3hfc2VuZF9kYXRhOiBzZW5kX2Rp
ZmY9MTYgbXMNCi4uLg0KWyAgIDQyLjgxNzI0NF0gY21kcV9tYm94X3NlbmRfZGF0YTogc2VuZF9k
aWZmPTE2IG1zDQpbICAgNDIuODQ0ODkxXSBjbWRxX21ib3hfc2VuZF9kYXRhOiBzZW5kX2RpZmY9
MjcgbXMNClsgICA0Mi44NTYzNDBdIGNtZHFfbWJveF9zZW5kX2RhdGE6IHNlbmRfZGlmZj0xMSBt
cw0KWyAgIDQyLjg1NjM2NF0gY21kcV9tYm94X3NlbmRfZGF0YTogc2VuZF9kaWZmPTAgbXMNClsg
ICA0Mi44NTYzODRdIGNtZHFfbWJveF9zZW5kX2RhdGE6IHNlbmRfZGlmZj0wIG1zDQpbICAgNDIu
ODU2NDEwXSBjbWRxX21ib3hfc2VuZF9kYXRhOiBzZW5kX2RpZmY9MCBtcw0KWyAgIDQyLjg1NjQz
MV0gY21kcV9tYm94X3NlbmRfZGF0YTogc2VuZF9kaWZmPTAgbXMNClsgICA0Mi44NTY0NThdIGNt
ZHFfbWJveF9zZW5kX2RhdGE6IHNlbmRfZGlmZj0wIG1zDQpbICAgNDIuODU2NDgyXSBjbWRxX21i
b3hfc2VuZF9kYXRhOiBzZW5kX2RpZmY9MCBtcw0KWyAgIDQyLjk4NTY5NV0gY21kcV9tYm94X3Nl
bmRfZGF0YTogc2VuZF9kaWZmPTEyOSBtcw0KWyAgIDQyLjk5MjAxN10gY21kcV9ydW50aW1lX3N1
c3BlbmQ6IFIvU19kaWZmPTY2NjYgbXMNCg0KUmVnYXJkcywNCkphc29uLUpILkxpbg0K

