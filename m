Return-Path: <linux-kernel+bounces-218673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC6E90C386
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 08:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D6A21F26016
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 06:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9680D47A5D;
	Tue, 18 Jun 2024 06:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="G8M65vGv";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="FSO50Pwt"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6E01E53A
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 06:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718692006; cv=fail; b=BD5OWFVNTSk7Y+bKo6U5vpZZjgb0CFHNNb5Z7uAz2mng5yTqTatk+TYREo5laCNGbzD2G1Ptdtngknz5Vj+fe+rr81b+L7OQtFiTJcfDdKO9rcfTXkhdH5Za6uJHIRXwjO4zkqMAx1y7gTHh69ap95wHkvRf9FOtNclj5mBZNsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718692006; c=relaxed/simple;
	bh=RlNceAsuBBF3qsfcxFa4evOQ7PBtzvfDvuswffhA2+I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nczu4RDFZK9+HFmPtrauOLIQeb0KfXsidgUXkDZEWUMTvyZEVu+v2zQDvUN5zp4lRH31WFw38Yy1hKw52QqkxMKjkuY/eLjaUKKJLWEy26aSvrpGtqyAwhsGYqkIUfKknACegjXvxCh+eQUR+6PkZZ1OfLXtefEszGhQIyovL9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=G8M65vGv; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=FSO50Pwt; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b6f3e5202d3b11efa22eafcdcd04c131-20240618
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=RlNceAsuBBF3qsfcxFa4evOQ7PBtzvfDvuswffhA2+I=;
	b=G8M65vGvoEW8An58Tb+4joRuzaO1bwwZScvpK0yG76RsTfGIrXZl4LZr/Y5shO04drL+eDHqDsjciULjRWYIbzes8xLMnAOIQuX932RJ8+Lj5hPK0KJTlQuA1VO+nTsyXizDr5BNtS9h+ah53CdjptlTtuVMGT0H/QdfbW0IcrU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:023b51b6-6d8f-461b-a042-cd758227dfac,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:f0401f94-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: b6f3e5202d3b11efa22eafcdcd04c131-20240618
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 792450174; Tue, 18 Jun 2024 14:26:36 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 18 Jun 2024 14:26:35 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 18 Jun 2024 14:26:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXevNwMGcnf73OHYyHKHj3Fr3+kttw8Aca4pn1fDXqXcQVX2axw00Kz0HcCX5hGXotN+tO2GNjKEuAwkYuBiFPcPuBxUh6aFEsgpUrRHcaF58ufaE4KTuZ6FeL6/JbRxY2FM7cnnhIVcByg7mFIdy1IRCcZbgM7I+7eDibGdnh59XH42Hd2Pxg9Mxgg71koB32fjN23IGT84xzUhVj/4Va/Z62C+/kJ0JjM5PTj5Phf3q4cjciIJiwOJUlT8+ODlCsK5mtV4tanlrovgOCMtH+v9n/kXTh2UUzz7uyhLMsXVtwh1n/Bp+C2f65IimSAyECYbQCAcaw4jlFOFuxuyww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlNceAsuBBF3qsfcxFa4evOQ7PBtzvfDvuswffhA2+I=;
 b=er2/6RkgDNYBk9zSpJHZg0jCB9uucE2fU9k1Pcyjuk2a5so48BKGhfQY9TbRDxBBxTlRayLx8V+icbFiPaynJ4xyTuCcVovfYOjs3pVAV1xL2tTs8cLoQGXq1qAV+ZQemZhLLfcJN2eoz66KNOU/iXMt8wd5iTMBPpxt06D7aZX1DCQiPcVl/p2rF7egKCvWC7NOmAmS6J/WndaCC8wvjiyV/k2GKXS5t70HbYUROF/j9U0gtFloZdkVEoSfhpO7mu3c54jcm6wsZ7xl1hAbSfZUOaJe8qa3cGu1lvk4yCyMXM0Opfscd/o/lrGS0jargSTutmyTzvRdMihgRThbug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlNceAsuBBF3qsfcxFa4evOQ7PBtzvfDvuswffhA2+I=;
 b=FSO50PwtMpuGlCzRh6QaDseKZexjkcCOXGSV/I1pnh1LPyf2aSN81vIWkp/5kkwusA6Iw9PWKqIf2DHSeChkMVFE601vigK94oWCPStUo7xxv4YtxizvGY9vxgreEuBuTITl4u7ZhF5WEd/OZLbaicnbELO6844JN1NSBLa+lbs=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYZPR03MB8703.apcprd03.prod.outlook.com (2603:1096:405:b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 06:26:33 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 06:26:33 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "Markus.Elfring@web.de" <Markus.Elfring@web.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "jassisinghbrar@gmail.com"
	<jassisinghbrar@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>
Subject: Re: [PATCH 1/2] mailbox: Add power_get/power_put API to mbox_chan_ops
Thread-Topic: [PATCH 1/2] mailbox: Add power_get/power_put API to
 mbox_chan_ops
Thread-Index: AQHavg+OiJuR9pSQW0ygxmSkuSgnzLHHIdMAgAXy+IA=
Date: Tue, 18 Jun 2024 06:26:33 +0000
Message-ID: <69eb92ad3ecfe2295b1b0516938e824e8b222001.camel@mediatek.com>
References: <20240614040133.24967-2-jason-jh.lin@mediatek.com>
	 <36c0231a-9916-4734-9042-7a07f4cb85f7@web.de>
In-Reply-To: <36c0231a-9916-4734-9042-7a07f4cb85f7@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYZPR03MB8703:EE_
x-ms-office365-filtering-correlation-id: ed819721-c089-4aa1-c5a6-08dc8f5f9903
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?UitZbGNjaVhYdFBuVFVsNHNwUnlHV0VCdk8rMXRHaG5GNE5vblQvbmYvYm5l?=
 =?utf-8?B?SDl2c05WQzNZNmpjZWhwN3J5NHQ2NldWWDIzbFZwbzdlaHhTN25XQ1hldUFO?=
 =?utf-8?B?TEJJVGdvRm9ONzZjUWdneVVHYU1rL1lUdHVGTmNsbkQ4N2dWT2E2a0w1eDMz?=
 =?utf-8?B?cllKcUpCbEpTbVJHQ0VjM2NIcnhpT2xkbUtXVlJpd0FOVUxCTHRIOGRUekJP?=
 =?utf-8?B?bEVrOC9ydVhwNzhGM2VCbjA1NVJYUHZPTGdHSWRMbXdmMVFKY2hSbndYOVhy?=
 =?utf-8?B?bXRjRGpnSVVjL29RQVE3Y3VLR1RmOEw2RXRxa2U4ZVB6Mlc5cDJ1T0pFcGdQ?=
 =?utf-8?B?aEoyaTFPZWpHQ1l2ams4UlVPMjdLVk00N1hJMnByODlVdFBWSXA3ZlJlbWZx?=
 =?utf-8?B?WU9NaSs4ZjdCVUp6Tk1iNEJsL1BzY3ZTU1JLclFKeUkrRlNBazJmMkMvZnZW?=
 =?utf-8?B?QTRZczAxR1NKNkVnUkFWU0hacWJWL2VlU1hvWEZoYjBKYzlYQTNhMWx0YzRi?=
 =?utf-8?B?eEhlaCsyVkJhRkVjNmkvb0h3YlVlSkErelQwbDNkQjBVbDNiYWNRQ1UwTFpF?=
 =?utf-8?B?SUdjU3h3aWt6OTMrYUtyQjd2Yk1OK1BVRDZ1UEJTK0dyRzNOL1ZOeDVmcFFD?=
 =?utf-8?B?Nm1zR0JiVHNQY1d3YXVoQTZTT3R0R2J1YUV0UXVGU3RicFJsNVp6dEh0d3VZ?=
 =?utf-8?B?QXBlMnJkclpQMytrQWhBUGI5NVM0SmRJRmpIVGhHNG5tc0N2UnFUSjZvdDF3?=
 =?utf-8?B?WTREOE9WUXZkdExqNzBGQ2xZaGhNaGlwR3pJYkFucTJPeEJ1eFlHTTVXNFpU?=
 =?utf-8?B?ekVuVDVMbThPME9MUGhvbVI1enNmbWF0WkRSWHdpN2cyTWNSWng1dHI3U2hw?=
 =?utf-8?B?Z0JNNXlVWlFvZ0dUeE51VDhUalAvQk5vTHRkRjF1R0ZTSHhaVWxCbDdPNXRY?=
 =?utf-8?B?aGdPZzdwUzNBRDRGa09odHNjSmZDWUF2bzlhalYwelBQbU5xWllUQmJCV1JB?=
 =?utf-8?B?elAzS3drTnFvYUxjbkMwdzdlOFJaWlNENVl6TmdYYVRKZWZ6emk5a1ViQ3JG?=
 =?utf-8?B?b09oSzVWL2hhVEJ1b04xQXpKUWkzQWYxRzRtT1FZYUVVZ04yN1JXaHhjQVM1?=
 =?utf-8?B?anVTVGNmTGF6VVFpZ00xTGNhTWJ0YlNvaTZCUmxCd2JlWTJnYkwreXpwVVph?=
 =?utf-8?B?eFBmVjljUUVqKy9XMW56VEhydTJ0UTJtdm95RStDeHhnTjhKaWZSNXM0Sjlk?=
 =?utf-8?B?WEZhUXpzamZoRWlGYjBVVW9aN0RnbUxyTVEyU3RTVlFaWWJSZkRWR2FtU2hw?=
 =?utf-8?B?UCtJd2hUcElOK21xcUI0anpUQnR5L3hybnNPSkxxSUh2eG9VOW1LN0VYZGZC?=
 =?utf-8?B?SWN3OHdDUlM2Z3ZkT1pENC9kNXdUMHpaQUhOZURpenVteC8xdDRUMUZ6RHZC?=
 =?utf-8?B?dHdxVTExSjdJMXlMelRZUDNYaDc0a0t4REJ4NGhBQXJNWWVTVW9pa3lId2Jo?=
 =?utf-8?B?WGsrVVNxUlNURmcrOWVTK2NHcVVkNzlTRHl0RWgvR3Ewb2pqK3lXV2V5b0hn?=
 =?utf-8?B?MlMxVjd4TzNmUS9kdnpHQ0tLVHE5U1gySzBoelZDZzRDa0FSb2h1dDlIZE5z?=
 =?utf-8?B?STlvY08xMkFselRYQ3hncVhYL3lKbExHaGhQYXlhbG5QM3hVMTlGSEhKQ0dL?=
 =?utf-8?B?ZWtqYlZiYlkzaVlxRHhWMW1xRFdBNU1tbGxURkNpbURVUFVUWHU2SXoxUXMx?=
 =?utf-8?Q?RE1uXfjh6Pys/UUbN4My0D6UxWVQRtaDHiHSvLh?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bG0vamRlaWxncXY0NWRGcjB2SVBDNVhHOGs2N2pxZWx1ekVITlY4UEhzU3Fh?=
 =?utf-8?B?ZDRsdFl2cys3dnNaMUFhUWlSdXA5enpZcEgxK1NYY3FqNncrQzZqcktscVEy?=
 =?utf-8?B?VE9SUlVGeC9qQUkyaGtBWXlJbHo4djFIUUtZbE9lbVczZU5kVmJET3JKdUJ6?=
 =?utf-8?B?OEU2bnRqaVBNSlVKaDlncy91dzFFdkplQWJFOTBUTFlIcUhLajlIQU5GMDV2?=
 =?utf-8?B?OXFJNC9Obm9NQlRmeUEwSm5zWlgrQ0libzB1UTJqNmR4Z0tWNjZmRnprcGk3?=
 =?utf-8?B?U2hjVHlIZWsra29VUnBvZHRXWnpGN20xMHV4VXdiVUJDR2swY3JPOGFpenl1?=
 =?utf-8?B?empRVVh3OGJWSlo0VTQwelR5cG9NN2xpNHNqaTdLVEVmaFp6TUl3dXVqRzEv?=
 =?utf-8?B?ZTRXZ1p4NCtyRUQzL2Nwa3VSMWxtNGloVE9nNlV0R0lYZjJBSTJmdkhlaWVZ?=
 =?utf-8?B?U0ZvUUdTcGkwNWZ3Y1pXNnNGRllMMnI0YTdKUmtxRGlRSHJ0YmtZaEpkcTMy?=
 =?utf-8?B?ME45a09BTGlNaFA4MzE0NHhabDduVVYrZ0pDYWoxSzdOM0k0Tm0xbEFaNk5I?=
 =?utf-8?B?NnpXM1RlYmtkNEpndmJOZG5jbk5OUU9kVFcwcU5pUHl2QW5lbEV5dFhRMDFJ?=
 =?utf-8?B?TWVUTXQ3Wko0cUQyamt0c0hPVXdHQ3p0M3l5VXdrWkx3UEZLdERxQ1M4OUQ3?=
 =?utf-8?B?V2piU0lsUlRGR3N2SlJDZnNPY2I4dVZCUHk0djg0NWQxeVZqYTJITWNMYVRh?=
 =?utf-8?B?VFZvakt2bGNCS3NjUGNkWHc4cENFTmVHL2l1bkZ2TlF4c1dTRVVUbWVKMzJL?=
 =?utf-8?B?Skt0YURzN2FLbmF0akw0Y0NSQWJyUUZzZXlMd2NNTmRLbTdXcVFwUjlGWjRo?=
 =?utf-8?B?Vm5ObXhqbmpqaHV4Ri9PbUNQQVFLWXJwSy9ua09VSjdvd2YzREFramNROFBH?=
 =?utf-8?B?R1hJcjlKV3Zmb2NYYmhxa21JSGFzaFVtU0pKZlFBNjdEaTdPUGRxUng2ZHdD?=
 =?utf-8?B?YXB6RU5XZVFGVjY2TzNnVDJmNFc0UHc3VkJRTktvOFQ2QXBQd0w4WDBtVUJ4?=
 =?utf-8?B?d0k4eWtoc0MrY2o5K1JPTG9UdXpJaFhrNmFkTnExc29QbGliNEFYZWtkSlFG?=
 =?utf-8?B?OWlzMlgvRWN6OUlhR0U2TmNrallTYm5ZYk05aW5JcnBkQUs0RzZXMXpsQUJ4?=
 =?utf-8?B?WVhDcWRPekRYOE45bit5QTRNRUFkZjl4T3NLMnprOGYvOVVhU0d1S3ZlQkpQ?=
 =?utf-8?B?bjM5c0JSK05WdGIwdnR5TVd2NmdxWUt3MzdwYUFVaitOYkJMdU5HNjNtdEl0?=
 =?utf-8?B?M2g5LytaZld5L2E2UmRlbW1lOUVYMHo0TDEwT1djcEhuRytOditHV2Jwc3ZY?=
 =?utf-8?B?L3hmd3NjU0Vodmk0WDZ3M0dDZlo3L3BTZ1BqbFdtV0VGbDhJcjNKcHNadmNr?=
 =?utf-8?B?dFNqVW1LanlmTnE1WWxnYTU5djRFMERhdXl2S3pNb1NQV0JMd1IvVEVSWFpx?=
 =?utf-8?B?SG10cHFRc3d4VEozQ1QyWmt0MzljL0YyUTdZWGNRRFl5dm0zVVhrWUNRN0d4?=
 =?utf-8?B?YW5WUUxCOEtMRG5HeHNpdkRsWkc0U2hQamlUUXpwWnpmQ0JEQlhnK3A5eWhM?=
 =?utf-8?B?dkRXYVBZZWJkdENYUFhHWS8zdGZNR2g2TjVuazU2c3lUQzdlT08yTVZEUnBW?=
 =?utf-8?B?MFpTNGZ6bHpxZS9RMTEreXFDMzBOemZKYmtBZUIzU1FlVWxKZ3U3U2RoWlJB?=
 =?utf-8?B?Z1pUSFRTcVpEMW5yZ2lSZi9HRkZQQUFzM1JaeHBMUlFnQklMYjNwamRYT0NY?=
 =?utf-8?B?RTRMZDl6QzNvTjZFZ2NUVHJTeXdub2lONDBQcG91OUlEWmVIUDNQQkxFMUtm?=
 =?utf-8?B?LzBYbzJHVVlCVlk2YlpsekVDdVNWWURBWFoyVWNhcHl5dzEyTk1mOWMyUjZI?=
 =?utf-8?B?Ym9ja2IyR0NDVWJ6TWhxMFUzVkV4OEVTWHhLb3NvQU5SV0Y1WFk4blVuVDdu?=
 =?utf-8?B?V1hwUm50QjZSM2YxSU0zQWc4RlpBNE5qWW9XaFA4SkUrQ0NWUWZOL2ppMm1K?=
 =?utf-8?B?MGNPNWR3UGN3RElHYkNVc0tYdFJWRHBldzJkODI4SFo4Ym14bmpxWG1mM0tD?=
 =?utf-8?B?QkRlMVAyOVdlWWlLRVU3dGJpNU40Rzlma25XcjVPRjJiQ2FEemtQd2NEaWV6?=
 =?utf-8?B?d1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF79A616239930478132269838F256A0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed819721-c089-4aa1-c5a6-08dc8f5f9903
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 06:26:33.1086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WyTtDEzm4qlOqipo0rqS5X8Ps4GDNtDX1aeWFjwx0wbEpaQULNIowvShCjfZJBH5WzTcrXlNqub/FMR+GmPmR/87rfgp7fEI+DVnJgqjMkw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8703

T24gRnJpLCAyMDI0LTA2LTE0IGF0IDEzOjM1ICswMjAwLCBNYXJrdXMgRWxmcmluZyB3cm90ZToN
Cj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3Ig
dGhlIGNvbnRlbnQuDQo+ICA+IFRvIGF2b2lkIHBtX3J1bnRpbWUgQVBJcyBjYWxsaW5nIHNsZWVw
IGluIGFsbCB0aGUgYXRvbWljIGNvbnRleHQNCj4gQVBJcw0KPiANCj4gICAgICAgICAgICBQTS1y
dW50aW1lPw0KPiANCk9LLCBJJ2xsIGNoYW5nZSB0aGlzLg0KDQo+IA0KPiA+IGluIG1ib3hfY2hh
bl9vcHMsIHdlIGFkZCBwb3dlcl9nZXQvcG93ZXJfcHV0IEFQSSB0byBsZXQgdGhlDQo+IGNvbnRy
b2xsZXJzDQo+ID4gaW1wbGVtZW50IHRoZW0gd2l0aCBwbV9ydW50aW1lIEFQSXMgb3V0c2lkZSB0
aGUgb3RoZXIgYXRvbWljDQo+IGNvbnRleHQgQVBJcw0KPiA+IGluIG1ib3hfY2hhbl9vcHMuDQo+
IA0KPiAqIEhvdyBkbyB5b3UgdGhpbmsgYWJvdXQgdG8gb21pdCB0aGUgd29yZCDigJx3ZeKAnSBm
cm9tIHN1Y2ggYSBjaGFuZ2UNCj4gZGVzY3JpcHRpb24/DQo+ICAgDQo+IGh0dHBzOi8vZ2l0Lmtl
cm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVl
L0RvY3VtZW50YXRpb24vcHJvY2Vzcy9zdWJtaXR0aW5nLXBhdGNoZXMucnN0P2g9djYuMTAtcmMz
I245NA0KPiANCg0KT0ssIEknbGwgcmVtb3ZlIGB3ZWAgYW5kIGNoYW5nZSB0aGUgc2VudGVuY2Ug
YmVsb3c6DQpBZGQgcG93ZXJfZ2V0L3Bvd2VyX3B1dCBBUEkgaW50byBtYm94X2NoYW5fb3BzIHRv
IGxldCBjb250cm9sbGVycw0KaW1wbGVtZW50IHRoZW0gd2l0aCBQTS1ydW50aW1lIEFQSXMgb3V0
c2lkZSB0aGUgb3RoZXIgYXRvbWljIGNvbnRleHQNCkFQSXMgaW4gbWJveF9jaGFuX29wcyB0byBh
dm9pZCBjYWxsaW5nIHNsZWVwIGluIHRoZSBhdG9taWMgY29udGV4dC4NCg0KDQo+ICogV291bGQg
eW91IGxpa2UgdG8gaW1wcm92ZSBhbnkgaW5kaWNhdGlvbnMgZm9yIGFkanVzdG1lbnRzIG9mIGRh
dGENCj4gc3RydWN0dXJlcz8NCj4gDQoNCllvdSBtZWFuIHRoZSBkZXNjcmlwdGlvbiBvZiBwb3dl
cl9nZXQgYW5kIHBvd2VyX3B1dCBpbiBzdHJ1Y3QNCm1ib3hfY2hhbl9vcHM/IElzIHRoaXMgYmV0
dGVyPw0KQHBvd2VyX2dldDogQ2FsbGVkIHdoZW4gdGhlIGNvbnRyb2xsZXIgbmVlZHMgdG8gaW5j
cmVhc2UgYSByZWZlcmVuY2UNCmNvdW50IHRvIGtlZXAgcG93ZXIgb24gZm9yIHRoZSBkZXZpY2Ug
b2YgbWFpbGJveCBjb250cm9sbGVyLiBJdCdzDQpvcHRpb25hbCB0byB1c2UgUE0tcnVudGltZSBB
UEkgb3IgbW9yZSBjb21wbGV4IG9wZXJhdGlvbnMgdG8gaW1wbGVtZW50DQp0aGlzIGZ1bmN0aW9u
Lg0KDQpAcG93ZXJfcHV0OiBDYWxsZWQgd2hlbiB0aGUgY29udHJvbGxlciBuZWVkcyB0byBkZWNy
ZWFzZSBhIHJlZmVyZW5jZQ0KY291bnQgdG8gcmVsZWFzZSBwb3dlciBmb3IgdGhlIGRldmljZSBv
ZiBtYWlsYm94IGNvbnRyb2xsZXIuIEl0J3MNCm9wdGlvbmFsIHRvIHVzZSBQTS1ydW50aW1lIEFQ
SSB0byBtb3JlIGNvbXBsZXggb3BlcmF0aW9ucyB0byBpbXBsZW1lbnQNCnRoaXMgZnVuY3Rpb24u
DQoNCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVk
aWF0ZWsuY29tPg0KPiANCj4gRG9lcyBhIGRvdCByZWFsbHkgYmVsb25nIHRvIHRoZSBwZXJzb25h
bCBuYW1lDQo+IChhY2NvcmRpbmcgdG8gdGhlIERldmVsb3BlcidzIENlcnRpZmljYXRlIG9mIE9y
aWdpbik/DQo+IA0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9n
aXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvRG9jdW1lbnRhdGlvbi9wcm9jZXNzL3N1Ym1pdHRp
bmctcGF0Y2hlcy5yc3Q/aD12Ni4xMC1yYzMjbjQzOA0KPiANCkEgZG90IGlzIG5vdCBpbiBteSBu
YW1lLCBidXQgSSd2ZSBiZWVuIHVzaW5nIGl0IGZvciBhIGxvbmcgdGltZS4NCkl0J3MgYmluZGlu
ZyB0byBteSBlbnZpcm9ubWVudCBldmVyeXdoZXJlIGFuZCBpdCdzIG5vdCBlYXN5IHRvIGNoYW5n
ZQ0KaW4gYSBzaG9ydCB0aW1lLiBCdXQgSSdsbCB0cnkgdG8gY2hhbmdlIGl0IGJlZm9yZSBzZW5k
aW5nIHVwc3RyZWFtDQpwYXRjaC4gVGhhbmtzIGZvciB5b3VyIGFkdmljZS4NCg0KUmVnYXJkcw0K
SmFzb24tSkggTGluDQoNCg0KPiBSZWdhcmRzLA0KPiBNYXJrdXMNCg==

