Return-Path: <linux-kernel+bounces-248506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AEE92DE2F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 04:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D45A91C21461
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 02:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004238489;
	Thu, 11 Jul 2024 02:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EwfiOiPh";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="XeJ4xwtA"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66047383
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 02:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720663257; cv=fail; b=Yh7dt4Q9QFN6cY3fDarDKu1ok/ds+aF1bj01awxU8tixkhJi4WCM4T5GhPkVWim2ARR57AsMrgGyXKfCjtozLxK/XzZpPUvclR3lT0uZE7QyJsZ1y2E4F5u4ORb9A6/aEpeXwRfRQvGxkfjqHSodSBcq/XyfXQSYDAiXkr8d7+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720663257; c=relaxed/simple;
	bh=G2gfBESLlJ89akK71hr9/LBGcNKT3Qt8jmF/UgGPxhw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B00PNHsUCLoansEc2c/Rbrx0iCBIM5NtMRris36uxvVFfKKqxARmSF+4VdbJ77CV928cvCjh6yxj+k1UJ5qPdr9YhrnRumt/21d+iMWP0vsg26RPad3CT4obpqm7iGunjyHDIrmtr5r+yt0mmVYxCmPBZr7DM1TxIP8JAbLzfdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=EwfiOiPh; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=XeJ4xwtA; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 60923b6e3f2911efb5b96b43b535fdb4-20240711
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=G2gfBESLlJ89akK71hr9/LBGcNKT3Qt8jmF/UgGPxhw=;
	b=EwfiOiPhDcdLR/sylyFk69AlDhv1PqN4X8soa2JeIbvVkoEFL3g+XQ3Kp7raGVsLA+urBrpFWWhBfdamCVD24vN1YQvn1u/EiV1/DZpaqGqmHW3q4AuzbQpU5HwKBIaEL8EywFEd4XXMpTnKJn1NBwRuRuGcU6BDiJ2AMnK3Lf4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:d6347b60-679e-443f-ab44-a7c57b3580c8,IP:0,U
	RL:-32768,TC:0,Content:0,EDM:0,RT:0,SF:-32768,FILE:0,BULK:-32768,RULE:Rele
	ase_Ham,ACTION:release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:57f82745-a117-4f46-a956-71ffeac67bfa,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:nil,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 60923b6e3f2911efb5b96b43b535fdb4-20240711
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1962833901; Thu, 11 Jul 2024 10:00:41 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 11 Jul 2024 10:00:42 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 11 Jul 2024 10:00:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DnoJ5CISB59MWwTSbJtvnq3yMDumGwe62DkZjEwePskQ2ihBPAnJOB7QrKsUdaz9PZqZPjGhz9/xTBAj0UvYGxIFpmdE1Y4LYuymwbPjHub0rs+isByj3V0DSWUCxTrywDToIBJYLoOssMDdO+IbyP9yy/+6PeVwlq5i6y67KeTQpAt6w3dT+iLvHG7GyrelWMIAbe668ZHlhfvuAyplx/OsMCL5fXJuiejItDsRoKk3xH0+5fN0aWTlsgC4IxWFDqRRGDTM4gQDI31llunn4uiFK8RN05fFX+G1IaASK6MPzvmdOK1PS37WFzzk+mgWjk4SMZwxe6skWyKVv3taHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2gfBESLlJ89akK71hr9/LBGcNKT3Qt8jmF/UgGPxhw=;
 b=QPQoKxzW+UzTlLf4MrSIjt90sa/i1pdrMuRUnxCldkRYmyFggkPjlFCWfI5IKlbBIBJMfDn6pEAL/9+gg4jazdZ0xJHNVCh9214rrNrHZTdnmjEGlgjYtUFMs+lFtqsiN3LZoZ5Y4BHeBmt3vN1iZ8B53oIDzq+9H6B8BykHgLJbUIlYGNlcbXdOIB1TBaPGWlJQedjmqgD9Hy8efs2riRi09Hy626gktVMWPX1+1lPC/L3HQ17TqG1Q8yzd5BWHFetMcTXkcPTsc4NNg0jEzDUsCuItpMqbpxOSqorhOw0CwjrJ71NyuwchcbPSlHSe/sfsmS346bVSwJBZqqBIkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2gfBESLlJ89akK71hr9/LBGcNKT3Qt8jmF/UgGPxhw=;
 b=XeJ4xwtALj2lbgWedgXBnMZK7kvXXXAO1dHsqyBqkY6Qopp3aSv58byAQGIXQyTu6w6XbYPslo5uzDXW0Uwxu9W8VBP24RRqc//+qY+pCTZqPov5uFf8MNPEbgZQ+nc+ckI2gBEts28iMHybyshwFjRuWtTk7Dlbdgkh5LtIj7Y=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYZPR03MB7242.apcprd03.prod.outlook.com (2603:1096:400:28e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Thu, 11 Jul
 2024 02:00:39 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%5]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 02:00:38 +0000
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
Thread-Index: AQHavg+NdbRKcT+3skGSUl4IqMicy7HMSVSAgADxdQCAAHoqAIABEY4AgAB6xoCAAPnzgIAAh/UAgAYULICAAGkzgIAApk4AgAALTYCAAek2AIACwj0AgAi2BgCAACiYgIACTBWAgACwkoCACHc+gA==
Date: Thu, 11 Jul 2024 02:00:38 +0000
Message-ID: <e860d67f578f1963d785dcc0423936fe5de20547.camel@mediatek.com>
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
	 <092d917b4cae2762317a8739c874855554ae913f.camel@mediatek.com>
	 <CABb+yY2-KWYORo_-ZWafyM0VJnh8-2wefvCpeDsK204qB0TchQ@mail.gmail.com>
	 <3f655bc4e1e60cd5e0dfc9baa018553fa8892826.camel@mediatek.com>
	 <CABb+yY2zBY_3nEYajdhRNfwb+bPMpFOvbXrqY+jM9rB6qbjJNQ@mail.gmail.com>
In-Reply-To: <CABb+yY2zBY_3nEYajdhRNfwb+bPMpFOvbXrqY+jM9rB6qbjJNQ@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYZPR03MB7242:EE_
x-ms-office365-filtering-correlation-id: e8bac1d5-d005-4bca-d6c3-08dca14d42a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UEd2djVTb1MyWExLeVZFQnFNL1VPYlp0emJORlNxY3kwTE9hb08yN2gwOEZh?=
 =?utf-8?B?aXV0N0RucFZuSDY0Zlo4dUFRQWNXWXFjV3BHOGtHR1ZPOEN4amJYelowZE12?=
 =?utf-8?B?Uk9SeDRLdWFKZTJKdmZ5SFZBanVQb2ZBU095eE9RbE1sbkExSGZxdTllTEUy?=
 =?utf-8?B?SGorYnB3RzErWTVIdTBITG15d3dHVkdqSTYwMTdPakJ0Nzk0UUw1R2dNNTF3?=
 =?utf-8?B?RXpvZUJhSE12dldVbkRENW1EVmRxVDZLNlVhRUxtQ2EvSnJFNGFFSEN5bWZt?=
 =?utf-8?B?YitDNXFJSVh1VmxSVmppM3NRZ2VJbjI5d3p5MklIRUQ2b3kxMGNGYWNTb3hV?=
 =?utf-8?B?Q2h2WDJVdlpVZlh1a08yMzVZUFM2V3pDTm43dnRnS2JEK092TUlUUEg2ZEd5?=
 =?utf-8?B?bS9VcDBTekNoNFlxVngxYTJtcGlBQkdPLzBDemwrcGVlMUREdEFGcm1KMGhD?=
 =?utf-8?B?SWtUOE9jbWwxcjJHYjl5eGJ4RHorSzF0S2I5blFneXQyN3F5VDM4VTJrQTBT?=
 =?utf-8?B?b0o4d0F0MlpGd2tYbUVMT1lEeTZWbDYxc2Y5Z3J1KzJUZ1dvVGdKczRXTGJj?=
 =?utf-8?B?cGMraUJtTWNzbkd4eG1Ub1FQcHdnb2RCdXAzOHg1RGROT0g3YUI5Y2pmdm95?=
 =?utf-8?B?Y085VW9INVc3WVZ2eU5hL1NkaG0zR2MvRVdwUEhhNWswK3VNT25MYkVMNjkw?=
 =?utf-8?B?VldxOFN1OGZiK2tGRHdmeHNsblVFcVIvSUpZV3lkZGl0T1ByWGZJa09iSytK?=
 =?utf-8?B?R1c3RTNZMDZNMkF1SkkrdDhDTHh4ajgxTUdaWjU0Q3NDL3doc1d2RnFtNFhN?=
 =?utf-8?B?R1FPcnlENTdnTWtCTnpEN0w2NlpaQ25ZWG90U2pITEk0d2hTdEtRenlwSTR0?=
 =?utf-8?B?cXZ6SVBBYzE5WFZGbU9ZVUZwNDc2dyt1eGxXTTJjYnZWaHlXYlpVMXY4a3E0?=
 =?utf-8?B?c21QQmJmRjRuUDNrNGxYRk9WSDUvSTkvZFdmTi9ndDBhRm9zaXV1RjFZR2NN?=
 =?utf-8?B?OUpZdjNCYXdqT2VhaW13cDlmeGRObXkvMllXeFF1U1paRGxnTmlaMTRqSExJ?=
 =?utf-8?B?MzVjeHRqN3E2SjNNZmJpQjJPZlMvanBVYkJtSTZnT2VkSWw2bW9WZW5mQmtu?=
 =?utf-8?B?Q01lYlYzN2NySlNXbzJEWDZwMVY0TVJXWW5UcTJVbGRMTmVlYXFuUitsWGtN?=
 =?utf-8?B?NUhaWEJWWXJMRWIvZ3Z3ZU1iaDJwMTVBNmQwTS9uUDYyNk5Cak04bVR5ZWdr?=
 =?utf-8?B?OE9SVFZIdEJsVWxjdm1KVXlXdTdUdHByRHBnLy9PaERmakZQaWl2c0FNRlIw?=
 =?utf-8?B?ckV3NjhvaTlXQmEzN0FMNTRoQWNRcDhZN2lMNkN0NnhkdTlZUGwybWhxQXMr?=
 =?utf-8?B?bkpsbGJCZm54SU5GREZOR21IaHpPbTdNV0hZRUxpdUh3Z2hGa2lvOE02ZkVP?=
 =?utf-8?B?T2VHTDFBMEVOSWwyU2NTdU9URWdNTVk5VEUzZFdxTWJZSENpeDZBTHE5djlx?=
 =?utf-8?B?U0NTUllqbmp2bWh1NTJlK2QyRWtBMWcvTlNwMUh5NVB5N040VHdFTExyZDBF?=
 =?utf-8?B?SitWV3hPbkpIK0JZbXorYW92WVhrMnF4OXdudzJJUDVCOERycE5KZnQrZXlT?=
 =?utf-8?B?NTlMdDltWXYxWnNFN09pamhKa1p3SXRnWkhiVjJ5ZEFqOWJsMWhsZGtpbkFZ?=
 =?utf-8?B?VzVGcHhtSnVFMGl4S0dVbVlVWjdtR3Z4K2ZLWnBEdDZSMWlxc3pPWTNUK1dG?=
 =?utf-8?B?TytjZUlBK3lVUm12TXJJa2xVbStLUDF3UWtFOS9QMmxVckRqeFFKTmYybWtL?=
 =?utf-8?B?dWY0Z1Fxa2ZBc0JSR3BMYkhzQ0Z0WWhWcTRPblJmeTNJQldPcHVBUUhtMUpw?=
 =?utf-8?B?MHNMcGE2VUVXY0hWOUJMQmFOOUgwWDJFbFpCWjBPb3h0bkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGVEODlJeEhPbmgyWXZyazcrekhOcWVoVGJlYm1YbldLeEJWdHVDU2pIRjYx?=
 =?utf-8?B?UEFZZEk0dzQwNVArOEd1QUo4YUU0WUJZVHZLaW0zTGV2Vis1bVo2SHdURjZK?=
 =?utf-8?B?M3hpQVlWYWpMVFhvMk8rTFVtR2R6WnE5bkI2TWRqT0tYbmpzVmVQS2cwYW9T?=
 =?utf-8?B?MGczandPWVV1T24zandmYndRZ21OZXZOdkw1SFVrenJJSGtPZWJMTkpMZEFq?=
 =?utf-8?B?MlJ2SVo2OE9KT3EzeTY2YXVPOFJ6bzV3cGZmNGc2VkhUTE5uRWJkMDByejJW?=
 =?utf-8?B?YmVZQVB4WU9IL3NHalM4djk3R2xSRHpMaXJUd1YvYzB5ZitQN3JjVmlPam4z?=
 =?utf-8?B?WVRjZk1UZDVoR0M0UUUrQU1pKzNtSktsQlJlMHNHUGZWemxrVUFxYjR1YlZN?=
 =?utf-8?B?dXpIRTBoSnpJNExDdUFlSTUzbzB5TC91MFo3VXo3czJkWWlPZmFtWTlCaSts?=
 =?utf-8?B?V1lOWDJmU25RQXlHL0NmMEl6c2xJSkUzeG5JNUpUNUJZTUM5emdLRFpURmRM?=
 =?utf-8?B?SGhJUHYrVzc3NnRBT0pnTTZTdlJnd3RiT3U0QzVqU1prR0ZiYkV4NC93bkdi?=
 =?utf-8?B?aDJHeTNPM0lvWmtLSjR4N214b2RxKzJCN1ljdkYzRHBrSkJQMXlGUE91bnNI?=
 =?utf-8?B?Qm1td3hVc3M0SFNNYnJtVWhHbEpyWnFVVGlYSTZ4Y3ZRSnpPWVJpNlVEMElv?=
 =?utf-8?B?dWhsaSswVk0vaEV6QjU0WWpZS0huM0RKd1JRb01ZbWw2ZmxSbGtsYlRhVjZs?=
 =?utf-8?B?QVV2K0FXcGVIakJYNWlHRFdlSVZ2cXpnQXlVaUxsN2JLdnM2ZkFOb0s0d0hC?=
 =?utf-8?B?Q2NaRXhvNHRPcXY3dWdiS1ZDSXQ0blJETWsxbWVYTHpRU1V3cFE4MDE3cm9w?=
 =?utf-8?B?Z3pIbnRnenVmWlpqdkVDV2lOdDJUeG5WRlUwV0d6cVhIdjRlS0k3bGlXVWNr?=
 =?utf-8?B?SmYyMmNYbThvTGVGbEE4alJzNjhtWitHR21BRUovT1ZVMEJwb2pFWTA5MmlO?=
 =?utf-8?B?ckpxRGVtRFYvM1VjdFVkQUs4YmVhTThrQU02dTJxSnJuR2RQaTRjYXhoUlFs?=
 =?utf-8?B?WTFMbUdzNjU2UWJIdzZGWWlxR0dvUUp6Qjk5ZlR6eWovemZPWStrVTNJRWVM?=
 =?utf-8?B?ZTg1dy94WUhqb0JjZWEwd3FvV0NVdlJ5eGsxZWNVSktocG9KK1pwMHphdW5T?=
 =?utf-8?B?RjhpSXhvbE0rRjBGUkRYQlQ1K3gwaDR0ZVN2dnBhMG9JVGozTG1TMTY4UTh4?=
 =?utf-8?B?REtNZUxyM21ENitxbU5FWitCdGNYY2RiZUhxMHRSWGYvVEdnTVdQYWgvOGdC?=
 =?utf-8?B?dDhWRHA4NHlwZUtYbHdZYmFORGkyNGYwN1pqYTBXUmxldnc5TVVLYi9Gckx2?=
 =?utf-8?B?MDg5a0FxNk1LSncvNW1EUzlOV2IxUURxM3B1dU1xb1NsQXFsMGNsb1R5TkJn?=
 =?utf-8?B?T2doSnFrNWkzTTBBY1d1TWpycWVLa29vNnkvUU96cnpYcXBKazU5bGJ6Z2k1?=
 =?utf-8?B?VDNHVzZzbTFyYXVia09IUjk4cVk5M1pkR1plN2xhYk1ibUxNS2FJZHJnaU90?=
 =?utf-8?B?OFRud3lSNWRNdTlqazlFcm9yMGFET1RyUURIYlI0VGQ0V0xQR0psNmFVUERr?=
 =?utf-8?B?S0ZDRHdYa2tJTmRTWFdRVmhPZjNDTzBicG5rR0VWYjlOakt4c2FSODlPaTFR?=
 =?utf-8?B?TkhGS2JHazErWFNJaXV2NENRN1BScFYxN2FQbmNUYlF2RWZoVFQ4ZEhCSWpQ?=
 =?utf-8?B?WVpJU1dDN3VmUk1YNllyejFiVU1wbXhIZWVvTkhnVG9yeVcwUEV2NTRueUhZ?=
 =?utf-8?B?amFiL1BYV3NCN3ZpZ3lxUldBajhrTHVlZldWOEdjQzdndVdIZUdUYWtEODZK?=
 =?utf-8?B?YmE3bEEzdVVkMUVvRzV3OWFJSzZzSHdjOXR3clpsaEZLM1NhZElQNzh5aGdj?=
 =?utf-8?B?cHZPNkFYa3JIcE9jb3lXU2M5L2FlN0NJRjFIVW4xd2trUGRUNEdhK2xWYWdE?=
 =?utf-8?B?N1pray9xNnozdWd1cEsyZGZRRk9OYTloNy9CMVZrRVFVWWUwNEttRDVUR3Qr?=
 =?utf-8?B?VUUwanp4ZFc4aWNKN1gzbzZPOGhSUU8vTktJektwVGJjUlRnS2xVdlRaUWpI?=
 =?utf-8?B?WHovMEkwSE1XR2J3TlVITHcrdFMzQ01nU3RtOU1sRDRIUVRhR0VET1QwMTFP?=
 =?utf-8?B?aEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <798BCBE3F8273146941599FB0EAE4FE6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8bac1d5-d005-4bca-d6c3-08dca14d42a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2024 02:00:38.2183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i920frACVjamG7Ggn0rMKD7Xhd+cMGXyEj2BX/FuOZRye0tTDWS899RB41inkjqwqXg+tFYDNHfIKfMjrAA+6Nnz4fw4h2l6ZNH7ECz3mEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7242
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--28.769600-8.000000
X-TMASE-MatchedRID: eVEkOcJu0F46yy6RAAEPcya1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCpGpaLcbZyfwmlaAItiONP3XAvRa0tfJGl9eTSR8I6duJKi
	pJgRx1kO9ARb4GqetWhEMeZvj8UyyHVikQ9YmLLNPuMJi/ZAk8fQ7szeVKdNbfmBSyEqHyB8fPl
	xxE3mQs+qDbsXjlf43fkm3lgvG3csLd3u89FoqUWA/V00XWjDtTI0NfY99MMltGYTovTq6lhSHq
	BuoSMtNBDJZsWaVaTEXNPRK5z71bFLrVDh8B2c0oaP4nSNLOYsg0L4Xy2OHleOxOq7LQlGLLZi6
	Gg7lrEcAzbdODEF2vZGTpe1iiCJq0u+wqOGzSV1WdFebWIc3VsRB0bsfrpPI6T/LTDsmJmg=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--28.769600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	6E2F7F0ADEDD1F95405A026255F6D78E0DC3E43A51B2821AEF92385D5F5C1A782000:8

T24gRnJpLCAyMDI0LTA3LTA1IGF0IDExOjQzIC0wNTAwLCBKYXNzaSBCcmFyIHdyb3RlOg0KPiAg
CSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUg
Y29udGVudC4NCj4gIE9uIEZyaSwgSnVsIDUsIDIwMjQgYXQgMToxMeKAr0FNIEphc29uLUpIIExp
biAo5p6X552/56WlKQ0KPiA8SmFzb24tSkguTGluQG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4N
Cj4gPiBbc25pcF0NCj4gPg0KPiA+ID4gWW91IG1heSBkaXNhYmxlIG9uZSB0byBtYWtlIGl0IGVh
c3kgdG8gY2FwdHVyZS4NCj4gPiA+IE1ha2Ugc3VyZSB5b3VyIGtlcm5lbCBwcmludHMgaGF2ZSB0
aW1lc3RhbXBzLg0KPiA+ID4gT3ZlciB5b3VyIHBhdGNoc2V0LCBhcHBseSB0aGUgZm9sbG93aW5n
IGRpZmYgYW5kIGV4ZWN1dGUgeW91cg0KPiA+ID4gdXNlY2FzZS4NCj4gPiA+IFRoZW4gc2hhcmUN
Cj4gPiA+ICAkIGRtZXNnIHwgZ3JlcCBKYXNvbg0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL21haWxib3gvbWFpbGJveC5jDQo+IGIvZHJpdmVycy9tYWlsYm94L21haWxib3guYw0K
PiA+ID4gaW5kZXggYmFmY2M3YjBjMGI4ZC4uOTBjMDYyMGMwYWU2MyAxMDA2NDQNCj4gPiA+IC0t
LSBhL2RyaXZlcnMvbWFpbGJveC9tYWlsYm94LmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvbWFpbGJv
eC9tYWlsYm94LmMNCj4gPiA+IEBAIC0yODQsNiArMjg0LDcgQEAgaW50IG1ib3hfc2VuZF9tZXNz
YWdlKHN0cnVjdCBtYm94X2NoYW4gKmNoYW4sDQo+ID4gPiB2b2lkICptc3NnKQ0KPiA+ID4gIHsN
Cj4gPiA+ICAgaW50IHQ7DQo+ID4gPg0KPiA+ID4gKyBwcmludGsoIkphc29uICVzOiAlcFxuIiwg
X19mdW5jX18sICh2b2lkICopY2hhbik7DQo+ID4gPiAgIGlmICghY2hhbiB8fCAhY2hhbi0+Y2wp
DQo+ID4gPiAgIHJldHVybiAtRUlOVkFMOw0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+ID4gPiBiL2RyaXZlcnMvbWFpbGJveC9t
dGstY21kcS1tYWlsYm94LmMNCj4gPiA+IGluZGV4IDAyY2VmM2VlZTM1YTUuLjY0MzZlMWIyMmYz
NTMgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5j
DQo+ID4gPiArKysgYi9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+ID4gPiBA
QCAtMzE3LDYgKzMxNyw3IEBAIHN0YXRpYyBpbnQgY21kcV9ydW50aW1lX3Jlc3VtZShzdHJ1Y3Qg
ZGV2aWNlDQo+ID4gPiAqZGV2KQ0KPiA+ID4gIHsNCj4gPiA+ICAgc3RydWN0IGNtZHEgKmNtZHEg
PSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gPiA+DQo+ID4gPiArIHByaW50aygiSmFzb24gJXM6
ICVwXG4iLCBfX2Z1bmNfXywgKHZvaWQgKilkZXYpOw0KPiA+ID4gICByZXR1cm4gY2xrX2J1bGtf
ZW5hYmxlKGNtZHEtPnBkYXRhLT5nY2VfbnVtLCBjbWRxLT5jbG9ja3MpOw0KPiA+ID4gIH0NCj4g
PiA+DQo+ID4gPiBAQCAtMzI0LDYgKzMyNSw3IEBAIHN0YXRpYyBpbnQgY21kcV9ydW50aW1lX3N1
c3BlbmQoc3RydWN0IGRldmljZQ0KPiA+ID4gKmRldikNCj4gPiA+ICB7DQo+ID4gPiAgIHN0cnVj
dCBjbWRxICpjbWRxID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ID4gPg0KPiA+ID4gKyBwcmlu
dGsoIkphc29uICVzOiAlcFxuIiwgX19mdW5jX18sICh2b2lkICopZGV2KTsNCj4gPiA+ICAgY2xr
X2J1bGtfZGlzYWJsZShjbWRxLT5wZGF0YS0+Z2NlX251bSwgY21kcS0+Y2xvY2tzKTsNCj4gPiA+
ICAgcmV0dXJuIDA7DQo+ID4gPiAgfQ0KPiA+ID4NCj4gPiA+IFRoYW5rcw0KPiA+DQo+ID4gSXQg
c2VlbXMgQ01EUSBkcml2ZXIgaXMgbm90IHN1c3BlbmQgb3ZlciAxMDBtcy4NCj4gPg0KPiBoZXJl
IGFyZSB0aGUgdGltZSBkZWx0YXMgaW4gbWlsbGktc2Vjb25kcw0KPiAxMCA2MDA1IDUyIDg1IDMw
NCA1OSAyNyAyMDMgMjkgMjQgMjUgMzggMzMgNTcgMzQgMjAgNDEgMjggMzYgNDggNzEgMzUNCj4g
MjEgNDUgNTEgMjIgMzAgNDYgNDYgMjMgMTYgMTYgMTYgMTYgMTYgMTcgMTcgMzEgMTYgMTkgMzEg
MTYgMTYgMTcgMTYNCj4gMTYgMTYgMzIgMTcgMzIgMTcgMzAgMjEgMTYgMzIgMTggMzAgMjggMjUg
MjkgMjQgMzEgMjcgMTYgMTcgMTkgMzQgMzANCj4gMTUgMzMgMTYgMzUgMzUgMjkgMTggMzEgMTYg
MTYgMTYgMTYgMTcgMzMgMzUgMzMgMzkgMjAgMjEgMTQgMzQgNDkgMjINCj4gNDIgMzIgMTMgMjEg
MjQgOSAxMzAgMjMgMzIgMzUgMzEgMzIgMTYgMTggMzEgMzYgMzcgMjYgMTQgNjggNzYgMTExDQo+
IDUxNQ0KPiA0NTIgNjQgNDg0IDQ4NyA0OTcgNTAxIDUwNyAxNjEgMzM2IDUxNiA0ODYgNDk1IDUw
NCA0OTUgNTA0IDUwMSA1MDANCj4gNDk1DQo+IDUwNyA0OTUgNDk5IDUwNSA0OTYgNTAyIDUwMSA1
MDIgNTAwIDQ5NSA1MDEgNTA3IDQ5OSA0OTkgNDk2IDUwNiA1MDENCj4gNDk4IDUwNyA0OTAgNTA0
IDQ5NiA1MDEgNTA2IDQxMyAyOCAyMDcgMzE3MzEgMzQ1NTAgMzc4NCAzMCAyMw0KPiANCj4gRm9y
IGRldGxhcyA8MTAwIHdlIGRvbid0IGV4cGVjdCBzdXNwZW5kIGJlY2F1c2UgeW91ciBzZXQNCj4g
YXV0b3N1c3BlbmRfZGVsYXkgdG8gMTAwbXMuDQo+IEZvciBkZWx0YXMgPjEwMCB5b3Ugc2hvdWxk
IGhhdmUgc2VlbiBzdXNwZW5kLiBBcHBhcmVudGx5IHRoZSBjaGFuZ2VzDQo+IHlvdSB3YW50IGlu
IHRoZSBhcGkgc3RpbGwgZG9uJ3QgaGVscCB5b3UuDQoNCkkgdGhpbmsgImRlbHRhcyA+IDEwMCBt
cyBub3QgYXV0b3N1c3BlbmQiIGFuZCAiY2FsbGluZw0KcG1fcnVudGltZV9nZXRfc3luYygpIGlu
IGF0b21pYyBjb250ZXh0IiBhcmUgMiBkaWZmZXJlbnQgcHJvYmxlbXMuDQoNCj4gDQo+IEFsc28g
SSBzZWUgbWVzc2FnZXMgYXJlIGJlaW5nIHN1Ym1pdHRlZCBvbiA0IGNoYW5uZWxzLCBidXQgb25s
eSBmb3INCj4gdGhlICAnMDAwMDAwMDAwYTRkMzdiNScgY2hhbm5lbCBjbWRxX21ib3hfc2VuZF9k
YXRhIGlzIGV2ZXIgY2FsbGVkLg0KPiBVbmxlc3MgeW91IHNlbGVjdGl2ZWx5IHByaW50ayBvbmx5
IGZvciB0aGF0IGNoYW5uZWwsIHlvdXIgZHJpdmVyIGhhcw0KPiBzb21lIGV2ZW4gZnVuZGFtZW50
YWwgcHJvYmxlbXMuICBNYXliZSB0cmFjZSB3aXRob3V0IHlvdXIgcGF0Y2ggYW5kDQo+IHdpdGgg
cG1fcnVudGltZV94eHggY29tbWVudGVkIG91dCAodG8gYXZvaWQgc3RhY2sgZHVtcCkuDQoNCkkn
dmUgY29uZmlybWVkIHRoYXQgYXV0b3N1c3BlbmQgZGlkbid0IHdvcmsgd2l0aG91dCB0aGVzZSBB
UEkgcGF0Y2hlcy4NCkknbGwgZmluZCBvdXQgd2h5IGl0IHdvbid0IGNhbGwgY21kcV9ydW50aW1l
X3N1c3BlbmQoKSA+IDEwMG1zLg0KDQpSZWdhcmRzLA0KSmFzb24tSkguTGluDQoNCj4gDQo+IC1q
YXNzaQ0KPiANCg==

