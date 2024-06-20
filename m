Return-Path: <linux-kernel+bounces-222094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E2190FCBD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299311F2136E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 06:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE105383B2;
	Thu, 20 Jun 2024 06:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JN9Ijxcd";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="eIW3iyVa"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4942E26AFB
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 06:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718865192; cv=fail; b=QXaFMMDyDNcjbwcYmWHiGZazsIFHM1wo7CggnAjxDkPIgOZGM1qH2i+IHYacrOSuaoNPbHNjT/GibDIFM23mv/+/ml8EdiKUMxPsyUa7S/gkP7zNfos/qtJJ4mcvrWIeHbZ33Dhg3b/71Xam0R043PJ7phMoAYtWFc4nVLsOs2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718865192; c=relaxed/simple;
	bh=VmFg4EvENEIrfsD9x+GTGEkoSqgB3NZfVkbdgiPp31w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jnh8NO65wHncVpCzQsQsPWv9GoJdN/hnlxp036icghavGJzi+1lB4qeLFQ9f1KWi3scXNaqZuMOL3mfHSoZns5RvjU3e8cRhGBYWW9y9WAGpAtljLDhA9/ps7zyoqieXnbphXBLAATKyKts4Iem9K21GvNeFRgO70eiaCMunmuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=JN9Ijxcd; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=eIW3iyVa; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: edc15bc02ece11ef8da6557f11777fc4-20240620
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=VmFg4EvENEIrfsD9x+GTGEkoSqgB3NZfVkbdgiPp31w=;
	b=JN9IjxcdDjirnI0+BAuryMP5w771hd52IXVWnFE35NRdlfSvYTWYRIXVGgXDEJX9RdKcHZOCQ+MUZjTxl88b1To4PFxzyVV2sw12BsY3x7ZF/g72ve6akrHr1t6OO+z124OD0+1/e+u/1JjxABBfX0e6XxMQ3/Oe7OOZIv5lMzk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:5cf4c502-86a5-4936-a343-3cee64a5fce8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:556b5085-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: edc15bc02ece11ef8da6557f11777fc4-20240620
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1916671060; Thu, 20 Jun 2024 14:32:55 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 19 Jun 2024 23:32:54 -0700
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 20 Jun 2024 14:32:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFV10cASnaEMxsbN0PwE/1Vfz551doFzcfL49Z18aEAae53DMEySxW7CJHiKVi7dHJLx59pecDLPswPg+GKRYhVl1DO3vuoIrygOHO3uz8QlRPkHntI8K6lmEl6h8J18sVCUW1692pt5aGJ48oeH0adjVJCuAsl3+fj6iNlHQ2hez5p114Le8vPPGr3Q6XKlTXAgcI3UMMUkvnwF8aGbRNNTL4OR7ASlTbDBVzt1KFzCB/61W7JJNCzjwJx9855cLTDx1g1Fg2t3wvFXw2qU+xWQwia77pCwmyPnRKa0eeeumYaOLEPG30uYSWonNUIsMPpbbjAjpf9ZqnrC6+XIFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmFg4EvENEIrfsD9x+GTGEkoSqgB3NZfVkbdgiPp31w=;
 b=JU7IyV2SushBHwj0lBUyjm4FqtDHw158/ddRcpYpG6W4RIX+yXrFlwcrsQVwckM3Y2WIugzlsnSx00B/cJ5Og0y5GcTVSrce2ebeX5CcQysV7h2nadcASeRJVbywQaI22PWEGUJc5m7wwTIT0ziMYGUWfM6c3HuSl1/O6zAzJIfTIMPIeyfXHy9uH789Lj1ZITztsg9agjE/y8qswpedX+A0Kjqjx95WRKZDP8yEfS5hl9AwYxF0ZHTN4+Y+BW2L4wOMZBviPWd8YWsbZRlTlfKBwTPYmNGOb3oQ/HVO5Cl+5fwtT+GDGJEkzkpBQRVbdm7OGqY6qJnSi8dU1FlMUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmFg4EvENEIrfsD9x+GTGEkoSqgB3NZfVkbdgiPp31w=;
 b=eIW3iyVazCOG90CzZK2mik0PxIcZJ+X7KD2PpsZFQJwmWWZrkCMZdAsZQIt4h4LyCVfn2Wi28DgVtIqYdWPuZwJotLBIXVh3XhuoQF2dISfwjNz3TMJ22XSVA56/1/d+COOiYUzT2AKWNqsmnUsrl/EbQCJ+3REFiGtHDu5CyGU=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by JH0PR03MB7853.apcprd03.prod.outlook.com (2603:1096:990:33::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 06:32:52 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%5]) with mapi id 15.20.7677.030; Thu, 20 Jun 2024
 06:32:52 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
Subject: Re: [PATCH 2/2] mailbox: mtk-cmdq: Move pm_runimte_get and put to
 mbox_chan_ops API
Thread-Topic: [PATCH 2/2] mailbox: mtk-cmdq: Move pm_runimte_get and put to
 mbox_chan_ops API
Thread-Index: AQHavg+NdbRKcT+3skGSUl4IqMicy7HMSVSAgADxdQCAAHoqAIABEY4AgAB6xoCAAPnzgA==
Date: Thu, 20 Jun 2024 06:32:52 +0000
Message-ID: <b7ebc021d391452eaf2149976ea2d53fba3d89fc.camel@mediatek.com>
References: <20240614040133.24967-1-jason-jh.lin@mediatek.com>
	 <20240614040133.24967-3-jason-jh.lin@mediatek.com>
	 <CABb+yY2bwj2BcdJLGe1ZYwCrnXL3LtcePMb=wQPaBKorBSs2yA@mail.gmail.com>
	 <fc92d51cc6e55301c081ea2d589e1ba6cdd295ee.camel@mediatek.com>
	 <CABb+yY1L+YGjf6O9UgPYkS2gWAdo=7QoojSAUNWC_8o7XtZQSg@mail.gmail.com>
	 <1f815ff8-2b7a-48de-8b47-0bc9b3cb67ab@collabora.com>
	 <CABb+yY1Yy8o3ofAiC-uV+gDrO3QDTWz3_XTUMai_2uyrnj-VrQ@mail.gmail.com>
In-Reply-To: <CABb+yY1Yy8o3ofAiC-uV+gDrO3QDTWz3_XTUMai_2uyrnj-VrQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|JH0PR03MB7853:EE_
x-ms-office365-filtering-correlation-id: 75fd7e78-d363-4fe5-90ae-08dc90f2cfc7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?Z25ERjZVVTRpV2lSem9jTitjbml2Q0VuZWZYaXN4ZVFjRHJGMThtc0tuM2ZW?=
 =?utf-8?B?bmoyM21rUkFITk12ZzQ2UXhUeTc2SWsrVUh1RnV5RzBiUTFiWVNDVTkvaDlJ?=
 =?utf-8?B?dzhmQTVJa2VWdUNwQVhWZ21yV01UODFuT0JVbG5vSTZRMlp6R0FUMktOWWVH?=
 =?utf-8?B?ZjNyZTNBVXVTeWxtTjlwZzNwQkNHdTRrUDVWSkJUcSt2cmwxMWczWEZPSVp6?=
 =?utf-8?B?WVo5NWFKS0V0bk1VVm43UDJWWVRkOEJlRkRCOEJvSVFGRDZldHhyQTVZNFJw?=
 =?utf-8?B?R2h6T0lzZHhDNUF1L3VKMU1TUkhmSmNYc2dieGlWZSt3SnBVT053eDNrbEpQ?=
 =?utf-8?B?TmJQT2N4Qzh0NXZsazUycUZieURmc2Zxdm1vRmhPQU1OUlN5TERvSUZPOEZl?=
 =?utf-8?B?M20rRmYrckhKMFJGUnJCT3hwdDJTUm5UN3BhVHNSQk9hbmtYWDlyU1AzM2lL?=
 =?utf-8?B?WkdrbnlBdThkb002THhVN1poblh3SkxDYm1OOUlLMjVGSWRCTENacjJBdElw?=
 =?utf-8?B?QlNlREppUHpQT0s4YW51M3QvT2cvbmdlUkhNRjF1ZEgrWE5lRjVaWlYreTV0?=
 =?utf-8?B?YnlGNXdVc0szZ2luWVVBKzZERWtab2ZhdU95NFc1aGtXR2t4ajNycE9XNm9G?=
 =?utf-8?B?MzNCbHZCQkpJbjV5bEJ5c2pNVmVzSW80Z1BOTHdSSDgrQmdYWTdpeDFNajRY?=
 =?utf-8?B?NitLK3hvdDJSUUVRQzc0dmZ6bkhMeStHcDBraGFLMUkybWFsazZZMWFKUU9s?=
 =?utf-8?B?SUNRM0xBN25zdnp4ZkE4cXFlSWFBOUNUbmJiTUsyYnZCMDg5SnBmWmRPYklw?=
 =?utf-8?B?NXhnVENScjR3RVVEUEhUdWU2VEJ0dzJER3NxY3dOUDhBTkVRMHBuTkdxNm93?=
 =?utf-8?B?eUFsaFZjVWdCelV0NHZYa0tZYnErZ2owM2xEblpxOFhvV1JWU0ZRZG9iNDJW?=
 =?utf-8?B?eGttSWI4QUNTYWEyOUMyV1N6Q0dPYnEzeWkrbkptdG1COFRDbkwvdm5SMWw4?=
 =?utf-8?B?Zjd5TVBVWnJGelUwNlFwTHZFVzRmdWpvcnllS2hRMEFmSXZBQzM5MHVRSzhR?=
 =?utf-8?B?NzZGS0FsSnoxT2liak1wREJrdjZpWURsTVFFZnVoa2JlajFFSlZ0WE1wbUV4?=
 =?utf-8?B?dzBoWklNODY2d1lOVjdDUXJHWER5cCs5bTM0STNId21DMWpmdXpBRzFDUGw2?=
 =?utf-8?B?OVNKUVFLd0c5dHBTM1Z3Sk1ybkRQUk0zdVlIY0VveWk4RURNcDk5YmRCbFBP?=
 =?utf-8?B?YklCU0p0OFB0eDhicS9GMlU4azM5ekVoaC9PcGpsVS9SYjBhRHhmbG5sci9j?=
 =?utf-8?B?c2M3VHBRZ1dTdUZLK2RZbml0UDk1VWY0aFFheHpPUkEzaHo5dHJxZ3VReVhP?=
 =?utf-8?B?UUxaSmZPYmlra25qWEJGL2pnUWtBRkxERWg0ZFNIWkhCWkJtKzZ0d3J5VzF6?=
 =?utf-8?B?ekJDZzJNRS9ETGVjdXd5NmN3VTFOa1k5dWVSMGIzcmZIbVVTa3VkUnZGVFMx?=
 =?utf-8?B?Z25YblF1RXozUUFBbStFbGNQSk8vWU13ZDJLOFRYL2FOdXpVSkJUNVJMTlBQ?=
 =?utf-8?B?d0RZTmlPUVptK0xOSWlWc3RtRGIydEVIN2I4VkpTcFowRWxXaHlnZ1dmT3FE?=
 =?utf-8?B?cEZURkJaSlVKSFdrM2dYelU5OThrWERsYTZuanlRMWhDS0xSMTJ5NTZXWXh6?=
 =?utf-8?B?bWoxVU10VTFJcFNxNlhzNjNvMVdUMUsvNjhVOXQ4d1hhUHZpR3BpRVVCN1lr?=
 =?utf-8?B?ME1tRmVKck5XK3phUlU4SkRaTkFnblpLdHZuV0hlZmZJOGJLWGw2cWdwTi9M?=
 =?utf-8?Q?WC0eJ+iUbLJvxMfuKoH46tNH7KqNBHh3JG1Ow=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zis1OEdtcnVxRWZ2OWhjTGRvUHpGVUIzS0h1ejJIWm82SFdCMXZ2U2pHY3Mr?=
 =?utf-8?B?dFVkVktXMDhEdWpEdExqV2EySktXakx6VEVFZ1l5dksxbnorb2xTWmRLVVdo?=
 =?utf-8?B?aDFyeDMvUW1uN252V01oRkozWWhveUNHV2puKzlzMUhqU09JTzExL0dPUXdl?=
 =?utf-8?B?Y2FEWDd1WmRRNlZzUXFLZWd4TklmVkowb0tHWnd2S0c4dldhd3puaGpQancy?=
 =?utf-8?B?NGwvS2MxNHhIalBydjdBa0VuUGVTWnBzWUFEakhoSm1nWUttR0kyTU9rT1Z1?=
 =?utf-8?B?R2ovd0k0U0MwQkN0aTBKaUJUK04wc1ZncXR1dnk3am5SZFgzOG9LRHg1TjR5?=
 =?utf-8?B?U2xEazEvWjVYcjhwQkhGekk1SUhrb0g5Sk02L1F0SWcybURSUHFETU80Qktp?=
 =?utf-8?B?YVQ1cDhSRTJWR1kvZGhNY2lNN0U4WUpEcW5YOTZHMEdYOTdkdWdmU0tNeWdp?=
 =?utf-8?B?MXZqVUpvU1JVQ1FFQXB4OGhBOW4wTjQyWGtOY2tIWVJzYUl2alIxcmlRYTdN?=
 =?utf-8?B?YlFQYzJsdmtTdW5FdzlIRUd4aGUvQlAzdXA2ZGZiUFArMTlrU1czRVpoRGVW?=
 =?utf-8?B?MldiaTc0T3lRaEpxR0JaY3FmakJSTEcvcTY4VFhTb2pBNytrMGVyTi9RVWdk?=
 =?utf-8?B?aEc5Z3hvaUplRERySnRyODdDVWZ4UXZBelluSlhNVk1iTVRKY0RRV3BCMWoz?=
 =?utf-8?B?VWxGaGlPa0c0MlNEcG1ERndQOW83anMvQlFBcHBERXNhcnh0ZlBOMVEyUzM5?=
 =?utf-8?B?b1VxNEp0TzRyald6aDd4T0o2Z1h2YlJocTV6VzYxUUVHRzZVMGowZzVtUnIr?=
 =?utf-8?B?Q2szTDQ1Yy9qUUNCR1BPKzQ1WldwNEZaUWZoL29RelFBczBrck11Y0k2c212?=
 =?utf-8?B?QkhENkEyNDNOODB3MU53ZVZzKzNrWDNXNlNrNUpOUVNmQjJMeTJPT1RuM1N0?=
 =?utf-8?B?RGxSbDloclZKMlcybklubEE4UWdnVWZtdkNNTVJtbmZoVzMvU3JlWDlBaGJP?=
 =?utf-8?B?WndYOHBxR3QzQmNVM0ZnRlJMWlc5V1dEQ2pYYWtnb1R2RTMxR2NxV2owTW9V?=
 =?utf-8?B?YnFuRzUvL256YU9tNEpVcGZaRDErWmY1Z0NSa0hoM2QydTB5bVdzNDJTRytH?=
 =?utf-8?B?NEVYTksyZ2diaGZuVDBDMmJESnhJZDZ2SDBPT1JSbFcxdlZZVDlJQzU5UEJE?=
 =?utf-8?B?U1ZORHlxYXhtSklHbDZNUEVtdkpMdktMVHphT3BuOUo1U0NXM0FCczN6M2VQ?=
 =?utf-8?B?NEFCUm9UOE0rN0l3aE11Q1QrNkdtajZMWUFQWmdlbUhleUxsS1VJWGJkQ1Vz?=
 =?utf-8?B?K1hMVnFkSU5EcTVlb1lqcE12R3hheHpvVSttSzJ1ZERxUkwyampVTHJ0dW1p?=
 =?utf-8?B?TUkrcTNDRHQxbWlHY2FuMlZhUFl6eGkrWldRVUJua2xGMkNUWGQveUQyWE1k?=
 =?utf-8?B?ckNRV0hwYjIzK3MyWEZnQitrbEZYNTNRT0pkUDhlQ0pNdXJtN09HZmc2SmpE?=
 =?utf-8?B?T1dpYUpkWktEbEVRL2hBYXlaNmNrQzBraUJOZGE5WXZtSW1RallFMks2NytX?=
 =?utf-8?B?TVYrYmlST3B0WllLa1c3Mmg0RXpwMjd0TkdWZUpEc1lMdk52MnVFUzVRb1N4?=
 =?utf-8?B?WE1VYlJ4SE5ocHhiTUNmTkExYzJ6SEVuNzNnajRMQXZFWGpMc2g1dkpnckM1?=
 =?utf-8?B?L0NBUjdHSHJlWUlqVVFPcVR4U1kzMXFLNzRuRlJSU3JVcUM1ajhMeFZVdE1t?=
 =?utf-8?B?OXduSHY4emhUdkJ4RjNET2FiWUtoVTdTc3dvZkxmbFhjNG83c3gvblIxbis5?=
 =?utf-8?B?bHZFZ3RDVjFsSStOLzRlNlRQVzkxZzNSV1R4Sm9iaUlRdXhHcitGYXFsVi84?=
 =?utf-8?B?b09hWTNaY3Z4MFFNMFYrbTJhaGN4SkYxVVczOHF5OU9rVHAvdXJBS1o1YzNX?=
 =?utf-8?B?ODdhcnNQajkwM2VOVU5DRlhYcCt2OG9hZ3gyMWg1QkltZlBxeEF0SXBVT2NE?=
 =?utf-8?B?Um5LK2FLYnl3K1ZmQjBwLzY5RWR4ZjVrY3dXZmJJMURGbFZkM1NQWS9BcGxa?=
 =?utf-8?B?VzBaT2VaaU1KNnJlb09taE9WbzUrcUhkUWYxaXd0d1dHT0F3Z1BFaTQ3Qm5E?=
 =?utf-8?B?aTZzQlU2T3cxbVVXcDR5SHBvKzFxQ2hOQ0lWNjB2YXpteFRuaGZsa3lnRmdQ?=
 =?utf-8?B?c1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F68C65C18F50D4C8DCDC5E161632A34@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75fd7e78-d363-4fe5-90ae-08dc90f2cfc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 06:32:52.1708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OTCiSPdcgM0za9ZqhfGgl1rcB5W91BiXfM9SypN/E9AEZp1cbDLloz4n2GyX2oew4Gde4NqSjgLNFJOFg6Fnt80fv9sMmJtTAZwLaDWs4+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7853

T24gV2VkLCAyMDI0LTA2LTE5IGF0IDEwOjM4IC0wNTAwLCBKYXNzaSBCcmFyIHdyb3RlOg0KPiAg
CSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUg
Y29udGVudC4NCj4gIE9uIFdlZCwgSnVuIDE5LCAyMDI0IGF0IDM6MTjigK9BTSBBbmdlbG9HaW9h
Y2NoaW5vIERlbCBSZWdubw0KPiA8YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEu
Y29tPiB3cm90ZToNCj4gPiBJbCAxOC8wNi8yNCAxNzo1OSwgSmFzc2kgQnJhciBoYSBzY3JpdHRv
Og0KPiAuLi4uLg0KPiANCj4gPiBGb3IgZXhhbXBsZSwgd2hlbiBzdGF0aWMgY29udGVudCBpcyBk
aXNwbGF5ZWQgb24gc2NyZWVuLCB0aGUgQ01EUQ0KPiBtYWlsYm94IG5ldmVyDQo+ID4gZ2V0cyBz
aHV0IGRvd24sIGJ1dCBubyBjb21tdW5pY2F0aW9uIGhhcHBlbnMgZm9yIGEgcmVsYXRpdmVseSBs
b25nDQo+IHRpbWU7IHRoZQ0KPiA+IG92ZXJoZWFkIG9mIGFjdHVhbGx5IHNodXR0aW5nIGRvd24g
dGhlIG1haWxib3ggYW5kIHNldHRpbmcgaXQgYmFjaw0KPiB1cCB3b3VsZCBiZQ0KPiA+IGluY3Jl
YXNpbmcgbGF0ZW5jeSBpbiBhbiB1bmFjY2VwdGFibGUgbWFubmVyLg0KPiA+DQo+IEhtbS4uLiAg
aW4geW91ciBkcml2ZXIsICBzdGFydHVwKCkgaXMgX2VtcHR5XyAgIGFuZCAgc2h1dGRvd24oKSBp
cw0KPiBhbGwNCj4gdW5kZXIgYSBzcGluLWxvY2sgd2l0aCBpcnFzIGRpc2FibGVkLCBzbyB0aGF0
IHRvbyBzaG91bGRuJ3QgYmUNCj4gZXhwZW5zaXZlLiBSaWdodD8NCj4gVGhlbiB3aGF0IGNhdXNl
cyB1bmFjY2VwdGFibGUgbGF0ZW5jaWVzPw0KPiANCg0KSSBmb3VuZCB0aGF0IHRoZSBCVUcgcmVw
b3J0IG9ubHkgb2NjdXJyZWQgd2hlbiBvcGVuaW5nIHRoZSBjYW1lcmEgQVBQLg0KTWF5YmUgc29t
ZXRoaW5nIGluIGltZ3N5c19jbWRxX3NlbmR0YXNrKCkgaXMgdG9vIGV4cGVuc2l2ZSBvciBzb21l
d2hlcmUNCmVsc2UgaW4gaW1nc3lzIGRyaXZlci4NCg0KSSdtIHdvbmRlcmluZyB3aHkgdGhpcyBC
VUcgcmVwb3J0IGlzIG5vdCBvY2N1cnJlZCBpbiBkaXNwbGF5IHVzZSBjYXNlDQp3aGljaCBpcyBt
b3JlIGZyZXF1ZW50IHRoYW4gaW1nc3lzIHVzZSBjYXNlLg0KRG9lcyB0aGlzIG1lYW4gc2xlZXAo
KSBpcyBub3QgYWx3YXlzIGNhbGxlZCBpbiBwbV9ydW50aW1lX2dldF9zeW5jKCkNCmFuZCBpZiB3
ZSBjYW4gZ3VhcmFudGVlIHRoaXMgc2xlZXAoKSB3b24ndCBiZSBjYWxsZWQsIHRoZW4gdXNpbmcN
CnBtX3J1bnRpbWVfZ2V0X3N5bmMoKSBpbiBhdG9taWMgY29udGV4dCBpcyBPSz8NCg0KPiA+IFRo
aXMgaXMgd2h5IEkgb3B0ZWQgZm9yIGF1dG9zdXNwZW5kIC0gaXQncyBvbmx5IGJyaW5naW5nIGRv
d24NCj4gY2VydGFpbiBjbG9ja3MgZm9yDQo+ID4gdGhlIENNRFEgSFcsIGFkZGluZyB1cCBhIGJp
dCBvZiBwb3dlciBzYXZpbmcgdG8gdGhlIG1peCB3aGljaCwgZm9yDQo+IHNvbWUgdXNlIGNhc2Vz
DQo+ID4gc3VjaCBhcyBtb2JpbGUgZGV2aWNlcyB3aXRoIHJlbGF0aXZlbHkgc21hbGwgYmF0dGVy
aWVzLCBpcw0KPiBkZWZpbml0ZWx5IGltcG9ydGFudC4NCj4gPg0KPiA+IEknbGwgYWxzbyBicmll
Zmx5IChhbmQgb25seSBicmllZmx5KSBtZW50aW9uIHRoYXQgMTIwSHogZGlzcGxheXMNCj4gYXJl
IGFscmVhZHkgYQ0KPiA+IGNvbW1vbiB0aGluZyBhbmQgaW4gdGhpcyBjYXNlIHRoZSBnYXAgYmV0
d2VlbiBUWCBhbmQgQUNLIGlzIH44LjMzbXMNCj4gaW5zdGVhZCwgbGV0DQo+ID4gYWxvbmUgdGhh
dCBkaXNwbGF5cyB3aXRoIGEgZnJhbWVyYXRlIG9mIG1vcmUgdGhhbiAxMjBIeiBhbHNvIGRvDQo+
IGV4aXN0IGV2ZW4gdGhvdWdoDQo+ID4gdGhleSdyZSBsZXNzIGNvbW1vbi4NCj4gPg0KPiBJIGRv
bid0IGtub3cgaG93IGV2ZW4gYnVzaWVyIGNoYW5uZWxzIGhlbHAgeW91ciBwb2ludC4NCj4gDQo+
ID4gQWxsIG9mIHRoZSBhYm92ZSBkZXNjcmliZXMgYSBmZXcgb2YgdGhlIHJlYXNvbnMgd2h5IGF1
dG9zdXNwZW5kIGlzDQo+IGEgZ29vZCBjaG9pY2UNCj4gPiBoZXJlLCBpbnN0ZWFkIG9mIGEgc2h1
dGRvd24tPnN0YXJ0dXAgZmxvdy4NCj4gPiBBbmQgYWdhaW4gLSBJIGNhbiBwbGFjZSBzb21lIGJl
dHMgdGhhdCBQTSB3b3VsZCBhbHNvIGJlIGFwcGxpY2FibGUNCj4gdG8gU29DcyBmcm9tDQo+ID4g
b3RoZXIgdmVuZG9ycyBhcyB3ZWxsLCB3aXRoIG1vc3QgcHJvYmFibHkgZGlmZmVyZW50IGJlbmVm
aXRzIChidXQNCj4gc3RpbGwgd2l0aCBzb21lDQo+ID4gcG93ZXIgcmVsYXRlZCBiZW5lZml0cyEp
IGNvbXBhcmVkIHRvIE1lZGlhVGVrLg0KDQpJIGFncmVlIHdpdGggQW5nZWxvJ3MgcG9pbnQhDQoN
Cg0KUmVnYXJkLA0KSmFzb24tSkggTGluDQoNCj4gPg0KPiBTdXJlLCBpZiBzb21lIHBsYXRmb3Jt
IF9hY3R1YWxseV8gaGFzIGEgaGlnaCBjaGFubmVsDQo+IHN0YXJ0dXAoKS9zaHV0ZG93bigpIGNv
c3QsIGl0IG1heSBuZWVkIGZpbmVyIFBNIGNvbnRyb2wuIEFuZCBJIGhhdmUgYQ0KPiB3YXkgZm9y
IHRoYXQsIGJ1dCBldmVuIHdpdGggdGhhdCBJIGFtIHN1cmUgc29tZW9uZSBmcm9tIE1USyB3aWxs
DQo+IHJlYWxpemUgdGhleSBkaWRuJ3QgbmVlZCB0aGF0Lg0KPiANCj4gVGhhbmtzLg0KPiANCg0K
DQoNCg0KDQo=

