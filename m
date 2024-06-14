Return-Path: <linux-kernel+bounces-214372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5433090835F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 07:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDD78283A11
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 05:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2A613959B;
	Fri, 14 Jun 2024 05:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cbqlQhDt";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="s+IEvpcM"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12EB13212F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 05:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718343796; cv=fail; b=QZEgqLgE4mwpOcE9gvtI1fguqGZWf1OhlxEZvYr0N4JSnEDAogzNAysRSiZVaI5NJA/LDlJhLLkmiisfQ/N2VOUluofERfi9qMob/qcqTh8iIbS0dgZ2MMNbb6yVnbnHkjivYoQCYya9JjHQMosEUSEF8+V3ad/olIo1eQbCeYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718343796; c=relaxed/simple;
	bh=LRRq3XpX65yDu8Xj6OubtMrfBiJNkx8FP1SQjky5lco=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qjd/6DzlK4aaJynX7M+sj2ossxyq6btFqZkKcIDaaV6TkR2+joFTps/LI5PjGygtd0YK7EaN3X3pXc0aqwEeQGgIqVmfGwwkkYxDGw9M+7Gad6SqYAV+9/l77VzaLmhntTxB+jjrWdOJIm8q4lpXhoSWqogtcl9t6+iGWX4BfMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=cbqlQhDt; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=s+IEvpcM; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d6c6f6ea2a1011efa22eafcdcd04c131-20240614
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=LRRq3XpX65yDu8Xj6OubtMrfBiJNkx8FP1SQjky5lco=;
	b=cbqlQhDtAAKfLvdR0AOphdMqEp4GD4Tb6wqGldfs5ZOmPufZ7UIZ1tPK3nY+GFZ9HxIqGJSz3nMM9Ma4CdnXHxkbmPRMi43FvDx48cJQL56imErUSmcnfHxaqj411MPFG/Z7EROzvZzguVAPvFD1dWb3XKEdcaTFJI5dgH/hYjw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:54e68288-780d-4781-bf54-4d0c107a88f2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:f8c29388-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d6c6f6ea2a1011efa22eafcdcd04c131-20240614
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2051579634; Fri, 14 Jun 2024 13:42:08 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 14 Jun 2024 13:42:07 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 14 Jun 2024 13:42:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZQMIbZqwKSuErBDQBTW4ehl5zxYitm+hq33b05nDAA+izNx7OnbdI1z6Lklr+oW+Xk8YYljRGsMZW/33KbtA9+Fg+pgwrwR3ReytWZIMDd8qKsjJ9D+3YNhE6eSBRGBKwkFa16echiSrli525Y67zmIgQOcg66CcglDd1rKXMNEC53D7+VAW/k9FVJG3SXSKUGy7ksGzH5Vs8J0KE182gdeiOib7r4H1WIfk+ECQaJScvASFE4vAjJHAuFAhx3m70zQbevEn37UpI8+eAvFRYO7uUwa+a4FKgwTgGKxoXVacfpBAdUgwz97od/bmTnqaRt/7kMjJ6qV0bsyRnTwCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRRq3XpX65yDu8Xj6OubtMrfBiJNkx8FP1SQjky5lco=;
 b=gDplcIhHQINkKQDS+r4V/jooR4mzeDt6Da0WDWCgtqYhH/syIlQ/QBVSyW3KmMIp9OymBUfYd7t6Ojz5GOFSvwMjP9+3PgorwAuKdrrNeHYMZFqYjWMYa0DmUrViYeOaao4rGhY4pgyMLE8+eFBSfhxCWk6dx/xiCUN3mbT4F9wU3z+tXis6s1HUCUiLqdwoSjIMLSfFMdd5XOllhXoF3jlhorYZ8ZVCqfbsgOhQEzNjY9XELHsm6mjvknUjzX4uUGiS46UyNi34fdbyGRyDsMoXuZRrkW1/YqP6866QYqgVZfkfTug/liNDpa5umX42ZarL/gT8/AJlpB4pE8WcKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRRq3XpX65yDu8Xj6OubtMrfBiJNkx8FP1SQjky5lco=;
 b=s+IEvpcMX+XeXrJzWyH7ylrblxQpKIvW7ceGNPh7srcVxecGlnEFetRjqSXwZ8HIv9P3mdHxcLeiw18/W1iZIqEGF2SFw3XBMx0wzLRmFEjvf5/3R46IbHA95PPQ4CkSLegW2Ub9i9zuRUtKdS95HpqfnaBRoduPwOnfLcBVhbo=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB8217.apcprd03.prod.outlook.com (2603:1096:820:10b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 05:42:04 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%6]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 05:42:01 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= <Bibby.Hsieh@mediatek.com>,
	"jason-ch.chen@mediatek.corp-partner.google.com"
	<jason-ch.chen@mediatek.corp-partner.google.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "airlied@gmail.com" <airlied@gmail.com>,
	"sean@poorly.run" <sean@poorly.run>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "fshao@chromium.org" <fshao@chromium.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v9 16/21] drm/mediatek: Support "Pre-multiplied" blending
 in OVL
Thread-Topic: [PATCH v9 16/21] drm/mediatek: Support "Pre-multiplied" blending
 in OVL
Thread-Index: AQHavgUxkv27uBRE70eZOpVJTFpNt7HGvxoA
Date: Fri, 14 Jun 2024 05:42:01 +0000
Message-ID: <a966988a520adc5aee5ee70657efd778d011ded0.camel@mediatek.com>
References: <20240614024620.19011-1-shawn.sung@mediatek.com>
	 <20240614024620.19011-17-shawn.sung@mediatek.com>
In-Reply-To: <20240614024620.19011-17-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB8217:EE_
x-ms-office365-filtering-correlation-id: d7de4621-504a-425e-617d-08dc8c34b6cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230035|7416009|366011|1800799019|376009|38070700013;
x-microsoft-antispam-message-info: =?utf-8?B?NTNhT0hnMWZZNEZMN3ZzRVAzd01tSlcwd0RVYlNoQ2ZMOHlvbnFRR3hEWTl2?=
 =?utf-8?B?NWY5TmtVb1Y2V3lhOW5SaUQxanQvM2h6WGpyL1NMb3hNci9QdG11Y1pZZVBp?=
 =?utf-8?B?M2hROVdwWGpnYjM3YlVXUThhTFpqYWVCR09RV2RTUzVGZUFidC9sQWNYdjky?=
 =?utf-8?B?K1NzTzJGYTB2a2JhOWF4TVM2QTU2SVRDNXFXUU8rME1yYlpXR2VwTURKVUNP?=
 =?utf-8?B?TFZjMFY3SU5IMWVhMXE2WTk3L0dTMytRc1BKT0JQM2FNYWQ0WUoxNFZMWDBL?=
 =?utf-8?B?dGZTVTVQQmEraUZiZzJJNE52VHBmQ3JTanhrYVo2Q0VXZnFab3A2R00rSi9w?=
 =?utf-8?B?UnVFaGFRWGNyTzBlTndDTHZYOWY5V3RhZ3JGS29oTHJ5WmsyN1VGMXhXU0h5?=
 =?utf-8?B?Qml2aXV6YlM4dVVDVGptVjJ6eG95azdLQk8yYmFIM1RRR0FxZ2IycUdiaXM2?=
 =?utf-8?B?Um9qTDdQQWgxcm43ejQvR044Z3prNHdVYThKWTVFcWU5YTljejRUL0xRbmlx?=
 =?utf-8?B?S1ZaVlY2bGx4S0luZWpUQ1BxWDFQZWtnT1hRdVdSV3VzQnZZOXdwYTlLejF0?=
 =?utf-8?B?eE9KVG5YTDAweTRmeEIzZ0oyN3AxT0Q2dklFNDNkK041WjkyTE5mbUlNTXM5?=
 =?utf-8?B?MlUyWStJNFRNUVQyWHMvVnlVbnBZWTdNUmMwWVVPd2t4ZHYvV0YwOXU3WFow?=
 =?utf-8?B?TU5QQ3EzdURaSGJMWlJ6VG9NdVQybk9HNEh3Q1dWcC9qRnErMndVcGZqSWg0?=
 =?utf-8?B?Q1g2b1Iyb3NwZmF2MDMyeEZBd3dSQnVOYldlSzdhaHUwQUNaSWczK3ppN21r?=
 =?utf-8?B?MThMcHErWElEenNCck82WlhNc1U2aG5IK08rZ0hPdzhnTmdQaDkzemk3cWUz?=
 =?utf-8?B?aDFwTWI4aGZONnRpY3k0S2lrQ29EMHZUMWZXL1lFQW9xS2NXalRJb2dDb3Jk?=
 =?utf-8?B?blpmUlp0eEFVMGNiaVo2Q3JCMnlGZDVDZWd4dzhocTlYUldNME5VS3RPQjMx?=
 =?utf-8?B?NnFJaC83M2x1QmRvMmxzQUNHZlViSndqTzhaOEo1bjd6K1MycDZ2b01CUk1y?=
 =?utf-8?B?VXcxenByTVhMQzdxc01LL3FmVFUwTDQ1WlMwVmxvM3dEQlJJUEZMWWFpTito?=
 =?utf-8?B?aFMwNUlRMmxHVC9MTm1saG5CaHpQTFd0SnRuTWhuR2Z3dTZidUYzbVc5cGhy?=
 =?utf-8?B?UkJ3RmgzS0lzdjd4c1NzcWpGV0s1MTlFMm4xV2pqRk1PbUJ1d0xpN3k0bktW?=
 =?utf-8?B?SWN4TVhYNmtncVlUKzNDdFgrdlFrcFA4dXVyeHJHYzdzZkdBUmltMGIwRjI1?=
 =?utf-8?B?SXNqeXpvM0pmOUIyVTFuNnl5TXZjbW5Vajk0MERuNGI2TVFiWHMzNW1Jdy90?=
 =?utf-8?B?RDlPMWFwbUh0aHRWcmRKRDdSdFB1TlpyalF3eWNWY1RUQWlPSy9kYUI2SnIz?=
 =?utf-8?B?ZXpOZlBCVXliMkYwb3JEUkZmbWpBNEJtVmhaMjVFdGxNL2NMaXloeFAxd2dT?=
 =?utf-8?B?ekdLaTJTaGV2ZE1pTDhQN3JiOGFvSk52MXRVUzRRaHRhaDlwMWRmUkt1eVVQ?=
 =?utf-8?B?eDJneU5jODZTUi9LSEFLRGRGaHVtUFR6b2RDNENYc3h2anlEK2N1UFlLMG5u?=
 =?utf-8?B?N24ybTVtZDN0L0d1TXRaVmE5cUUvY3lERmVkS1dlb3BEdDdTNmlkNElENUNC?=
 =?utf-8?B?RWYwRVpreE5rb1Zwcit2aUowVEljN2Z6SEtDbWlZK01PV3BHR0Y2UnFoanc3?=
 =?utf-8?B?bzZIb1o0NG1rYkxLZUN0RWkybU82RllaWFNackhmQ3hTZHFBTE9CRUltWldP?=
 =?utf-8?Q?NwOCpxPK33sXy4o6ccJvtPDRHUgcn+W9IQTU8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(7416009)(366011)(1800799019)(376009)(38070700013);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2lnVmdibHZ0MmxLTlpHS2V6L2NHT2w1cWNuYTM5Qit5c3QvRXB2em9jd3NH?=
 =?utf-8?B?NVlEZjJnUVU2ZWh5RVBZRHpZWDZUSW5xanJYTWVlL1ZSOXBYT2xCUVpXTnVY?=
 =?utf-8?B?Q0RJNTVlcElPL0x4d2JFQzZmQWtEMlJtd3NCMXowdnF6WFhzVVB2dFp5emYz?=
 =?utf-8?B?MzIzY1Q4d1ZaemJOTU1kanlXVElwcXpEN0FmQnpVRzhDQ3BTOXRUT1IrSGJm?=
 =?utf-8?B?bTVST3g1dXUrSHhqWnpMRlpYQ1dWVmhza2dLNUVURS9VdEdmbmx1T2lvS1Vv?=
 =?utf-8?B?amRqWHlaZUpSVnhSYnAzSW92N0pnbEJMQmRIUzZ3NW1WVWdYR3BXUWEyWkhP?=
 =?utf-8?B?bXk3UUMxdDBKUHc2STEranhjOWxEbE9YMTEvUXVmbG9wbzY3U242MEhVU3hD?=
 =?utf-8?B?VEdyU05SOXhkd2ZBOTcyUkNUMHV3QVVrL2w5R05TWmdBK2d3Z0xpVGUxRDBp?=
 =?utf-8?B?ZjNWZkd5eitlTmVNdDY1Vm5wVVVPN0RFRSs0UWF2MXhnb1o0VWVQMTBaSWJP?=
 =?utf-8?B?WG9DOU9Cc0txbHlXMHdzd0FVRXMwUk1tU3hSWnNXZWlaaElmWkZyZjJnZ3BW?=
 =?utf-8?B?QUZ1MVVuUHZkZUx3NEFqbjRyZUxjdzhzSkVzdkpaSkFKTVNuT25XeHNMNGtK?=
 =?utf-8?B?SHd3Vzhtcm5GZnlJR0FiVEN0NlN4cytSdEw3TWFCN0V4dWdYS0lhT3lFNDJE?=
 =?utf-8?B?eERLU2twd2t6VVNOMXVxcmtHTWhaWEgxZ3VoK1IwbFQ3SWtVTDFnZnBVUVpE?=
 =?utf-8?B?TElLS2FWZEd3Nzc3YWJVYTg5Y3V4RFBuWDdKQkxRcmR1RUxFa2lWZmFlRVJL?=
 =?utf-8?B?L3Q0US9CSHVJVmRpd01adWd3SXd1VnA5QkhLMUc4SGpDZjcwU0g5M0pRblNi?=
 =?utf-8?B?UXF3TDhxQ2lmTUZKSkp1WHBKcm8xbmNNWWFudjVoTXI0UDRSazBsUVAwS3Fv?=
 =?utf-8?B?QmxSY0JFVEhCZlJUZ0pTUjdPQkdUZWZRL1RzSGdXY3FSL0x4Mm5KM3Z4L0px?=
 =?utf-8?B?ZEFFdlJKS1M0T3NRSUtycW1ucWdDcDdTQU9Jd1FxYnFpOE84OXIxaENYWE9w?=
 =?utf-8?B?Yzc3YnB6L2JvTFgwWkl6UDNBQmZKVDkxZ2w0VmhOVXlRRmRDUlpMMWRZcFhS?=
 =?utf-8?B?RW5xdXgzZDdRVHVpbGdBR3VSMmQ1ZVF4TzJKeGxjRHBSQlYrSk95M3hEUEtM?=
 =?utf-8?B?bDh4UzN2UXFnMThwMXdjR0dCVHVXRDN1QkhPa2Z1Q2RXTWMrWGFmV2tnNVo5?=
 =?utf-8?B?a0xaM21NZnZweEZHYjg5dkJ1Vm5XcFF6aXlTcHoyc2pab0tIa2IybUtsWG12?=
 =?utf-8?B?d1A5OGZCSXRYVkF0RjZpdGZVUkd1RSs2M1NPeU9VempqVTEwS25Td1MrRFFx?=
 =?utf-8?B?Qlk5K2lGSGN4ZTdsVzhZeWJiSy9kQkxHV0J3aXAwUGRqczJDSXU5dlNHeW1i?=
 =?utf-8?B?emFQcG16QUc3c3cwdVZ6b1N6SXJXeGZseWF6b2FoOUhYTGJiU3VoRFlKTkNy?=
 =?utf-8?B?WWRmRnUrWHhqdzNCR1ZyY21jTURnbnZCWUtoZ0k0TFE2T0RUeEVLbkNBd0tW?=
 =?utf-8?B?MGlqSmRWVGNnWU5JQmY5RmtTKzkvTXlNVEU2cDdJM3UzU0dmaUR3V0h1ZFQ0?=
 =?utf-8?B?c1drQWJ5S0wwaVBmajlDVUdaOFZ0NEg1OHBXaEc3ZkFFSlRsdzJtTGYwR0J1?=
 =?utf-8?B?SlFRZXBSdFZSR054NWdVd01sWlFZdlphSDhZWVBvNWNvVTR1WVhOU09xb3Vu?=
 =?utf-8?B?ekFkVFgvN2t4d09pZzBDSUVHRDJSYnBpckgwUHFPTml5ekY3UkRMckJock1X?=
 =?utf-8?B?U1NtRnNpeWNFdmpwK1pyKzJmbzJ2OW1kekhyZzZVa0xsZmloU3dyMlM2STdI?=
 =?utf-8?B?Rm5pWi9nSER6SE44MWFwVkJEYzJKbkxqOEZrMWtDekt0Vm1MQ0lJeXRkU3pp?=
 =?utf-8?B?bmtOVm9HVUFNeU9YUmJzRUM4dEFvS1VhOThzTngzV1Q5TWtIM0dqN1hQTS9N?=
 =?utf-8?B?RndoaTMyNGJQRUROZ3k0aW1lRzhUSWp6WWJCOHBJMlo2aStJb0JUQlE3YTIw?=
 =?utf-8?B?VnJuWTlQSUQ2ekVQb0RSZjgzNnNVYzk2WTN2ckxHa3NNMjZQcHRVSUw4c3J5?=
 =?utf-8?Q?o47vtfyUoW+IgS3/eLKX4gNyU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B911A0893CF4F47A91CDB7741F3F716@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7de4621-504a-425e-617d-08dc8c34b6cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 05:42:01.2490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iGQn4mTJ6moVopwZ5SS6EID8mouz5yIGpeya4R8jNen6a5kXucZWlLB1qafkD80jm0Afvo47aG3aJbbngs7X7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8217

T24gRnJpLCAyMDI0LTA2LTE0IGF0IDEwOjQ2ICswODAwLCBTaGF3biBTdW5nIHdyb3RlOg0KPiBG
cm9tOiBIc2lhbyBDaGllbiBTdW5nIDxzaGF3bi5zdW5nQG1lZGlhdGVrLmNvbT4NCj4gDQo+IFN1
cHBvcnQgIlByZS1tdWx0aXBsaWVkIiBhbHBoYSBibGVuZGluZyBtb2RlIG9uIGluIE9WTC4NCj4g
QmVmb3JlIHRoaXMgcGF0Y2gsIG9ubHkgdGhlICJjb3ZlcmFnZSIgbW9kZSBpcyBzdXBwb3J0ZWQu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBIc2lhbyBDaGllbiBTdW5nIDxzaGF3bi5zdW5nQG1lZGlh
dGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3Zs
LmMgfCA0MiArKysrKysrKysrKysrKysrKysrKy0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMzQg
aW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gaW5kZXggNjU2NzgwNmNmNGUyLi40N2QwYjAzOWE2MTYgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYw0KPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gQEAgLTUyLDgg
KzUyLDEyIEBADQo+ICAjZGVmaW5lIEdNQ19USFJFU0hPTERfSElHSAkoKDEgPDwgR01DX1RIUkVT
SE9MRF9CSVRTKSAvIDQpDQo+ICAjZGVmaW5lIEdNQ19USFJFU0hPTERfTE9XCSgoMSA8PCBHTUNf
VEhSRVNIT0xEX0JJVFMpIC8gOCkNCj4gIA0KPiArI2RlZmluZSBPVkxfQ09OX0NMUkZNVF9NQU4J
QklUKDIzKQ0KPiAgI2RlZmluZSBPVkxfQ09OX0JZVEVfU1dBUAlCSVQoMjQpDQo+IC0jZGVmaW5l
IE9WTF9DT05fTVRYX1lVVl9UT19SR0IJKDYgPDwgMTYpDQo+ICsNCj4gKy8qIE9WTF9DT05fUkdC
X1NXQVAgd29ya3Mgb25seSBpZiBPVkxfQ09OX0NMUkZNVF9NQU4gaXMgZW5hYmxlZCAqLw0KPiAr
I2RlZmluZSBPVkxfQ09OX1JHQl9TV0FQCUJJVCgyNSkNCj4gKw0KPiAgI2RlZmluZSBPVkxfQ09O
X0NMUkZNVF9SR0IJKDEgPDwgMTIpDQo+ICAjZGVmaW5lIE9WTF9DT05fQ0xSRk1UX0FSR0I4ODg4
CSgyIDw8IDEyKQ0KPiAgI2RlZmluZSBPVkxfQ09OX0NMUkZNVF9SR0JBODg4OAkoMyA8PCAxMikN
Cj4gQEAgLTYxLDYgKzY1LDExIEBADQo+ICAjZGVmaW5lIE9WTF9DT05fQ0xSRk1UX0JHUkE4ODg4
CShPVkxfQ09OX0NMUkZNVF9BUkdCODg4OCB8IE9WTF9DT05fQllURV9TV0FQKQ0KPiAgI2RlZmlu
ZSBPVkxfQ09OX0NMUkZNVF9VWVZZCSg0IDw8IDEyKQ0KPiAgI2RlZmluZSBPVkxfQ09OX0NMUkZN
VF9ZVVlWCSg1IDw8IDEyKQ0KPiArI2RlZmluZSBPVkxfQ09OX01UWF9ZVVZfVE9fUkdCCSg2IDw8
IDE2KQ0KPiArI2RlZmluZSBPVkxfQ09OX0NMUkZNVF9QQVJHQjg4ODggKCgzIDw8IDEyKSB8IE9W
TF9DT05fQ0xSRk1UX01BTikNCg0KI2RlZmluZSBPVkxfQ09OX0NMUkZNVF9QQVJHQjg4ODggKE9W
TF9DT05fQ0xSRk1UX1JHQkE4ODg4IHwgT1ZMX0NPTl9DTFJGTVRfTUFOKQ0KDQpCdXQgSSdtIGNv
bmZ1c2VkIHdpdGggdGhlIG5hbWluZy4NCg0KDQo+ICsjZGVmaW5lIE9WTF9DT05fQ0xSRk1UX1BB
QkdSODg4OCAoT1ZMX0NPTl9DTFJGTVRfUEFSR0I4ODg4IHwgT1ZMX0NPTl9SR0JfU1dBUCkNCg0K
I2RlZmluZSBPVkxfQ09OX0NMUkZNVF9QQUJHUjg4ODggKE9WTF9DT05fQ0xSRk1UX0FCR1I4ODg4
IHwgT1ZMX0NPTl9DTFJGTVRfTUFOKQ0KDQo+ICsjZGVmaW5lIE9WTF9DT05fQ0xSRk1UX1BCR1JB
ODg4OCAoT1ZMX0NPTl9DTFJGTVRfUEFSR0I4ODg4IHwgT1ZMX0NPTl9CWVRFX1NXQVApDQoNCiNk
ZWZpbmUgT1ZMX0NPTl9DTFJGTVRfUEJHUkE4ODg4IChPVkxfQ09OX0NMUkZNVF9CR1JBODg4OCB8
IE9WTF9DT05fQ0xSRk1UX01BTikNCg0KPiArI2RlZmluZSBPVkxfQ09OX0NMUkZNVF9QUkdCQTg4
ODggKE9WTF9DT05fQ0xSRk1UX1BBQkdSODg4OCB8IE9WTF9DT05fQllURV9TV0FQKQ0KPiAgI2Rl
ZmluZSBPVkxfQ09OX0NMUkZNVF9SR0I1NjUob3ZsKQkoKG92bCktPmRhdGEtPmZtdF9yZ2I1NjVf
aXNfMCA/IFwNCj4gIAkJCQkJMCA6IE9WTF9DT05fQ0xSRk1UX1JHQikNCj4gICNkZWZpbmUgT1ZM
X0NPTl9DTFJGTVRfUkdCODg4KG92bCkJKChvdmwpLT5kYXRhLT5mbXRfcmdiNTY1X2lzXzAgPyBc
DQo+IEBAIC03NCw2ICs4Myw4IEBADQo+ICAjZGVmaW5lCU9WTF9DT05fVklSVF9GTElQCUJJVCg5
KQ0KPiAgI2RlZmluZQlPVkxfQ09OX0hPUlpfRkxJUAlCSVQoMTApDQo+ICANCj4gKyNkZWZpbmUg
T1ZMX0NPTE9SX0FMUEhBCQlHRU5NQVNLKDMxLCAyNCkNCj4gKw0KPiAgc3RhdGljIGlubGluZSBi
b29sIGlzXzEwYml0X3JnYih1MzIgZm10KQ0KPiAgew0KPiAgCXN3aXRjaCAoZm10KSB7DQo+IEBA
IC0yOTgsNyArMzA5LDEzIEBAIHZvaWQgbXRrX292bF9jb25maWcoc3RydWN0IGRldmljZSAqZGV2
LCB1bnNpZ25lZCBpbnQgdywNCj4gIAlpZiAodyAhPSAwICYmIGggIT0gMCkNCj4gIAkJbXRrX2Rk
cF93cml0ZV9yZWxheGVkKGNtZHFfcGt0LCBoIDw8IDE2IHwgdywgJm92bC0+Y21kcV9yZWcsIG92
bC0+cmVncywNCj4gIAkJCQkgICAgICBESVNQX1JFR19PVkxfUk9JX1NJWkUpOw0KPiAtCW10a19k
ZHBfd3JpdGVfcmVsYXhlZChjbWRxX3BrdCwgMHgwLCAmb3ZsLT5jbWRxX3JlZywgb3ZsLT5yZWdz
LCBESVNQX1JFR19PVkxfUk9JX0JHQ0xSKTsNCj4gKw0KPiArCS8qDQo+ICsJICogVGhlIGJhY2tn
cm91bmQgY29sb3IgbXVzdCBiZSBvcGFxdWUgYmxhY2sgKEFSR0IpLA0KPiArCSAqIG90aGVyd2lz
ZSB0aGUgYWxwaGEgYmxlbmRpbmcgd2lsbCBoYXZlIG5vIGVmZmVjdA0KPiArCSAqLw0KPiArCW10
a19kZHBfd3JpdGVfcmVsYXhlZChjbWRxX3BrdCwgT1ZMX0NPTE9SX0FMUEhBLCAmb3ZsLT5jbWRx
X3JlZywNCj4gKwkJCSAgICAgIG92bC0+cmVncywgRElTUF9SRUdfT1ZMX1JPSV9CR0NMUik7DQoN
ClRoZSBjb3ZlcmFnZSBtb2RlIGZvcm11bGEgaXM6DQpkc3QuUkdCID0gc3JjLlJHQiAqIHNyYy5B
ICsgZHN0LlJHQiAqICgxIC0gc3JjLkEpDQoNClRoZSBwcmUtbXVsdGlwbGllZCBtb2RlIGZvcm11
bGEgaXM6DQpkc3QuUkdCID0gc3JjLlJHQiArIGRzdC5SR0IgKiAoMSAtIHNyYy5BKQ0KDQpCb3Ro
IGZvcm11bGEgaGFzIG5vIGRlc3RpbmF0aW9uIGFscGhhIChJIHRoaW5rIGJhY2tncm91bmQgY29s
b3IgaXMgbGFzdCBkZXN0aW5hdGlvbiksDQp3aHkgY292ZXJhZ2UgbW9kZSB3b3JrIGZpbmUgYnV0
IHByZS1tdWx0aXBsaWVkIG1vZGUgaGFzIHNvbWV0aGluZyB3cm9uZz8NCg0KUmVnYXJkcywNCkNL
DQoNCj4gIA0KPiAgCW10a19kZHBfd3JpdGUoY21kcV9wa3QsIDB4MSwgJm92bC0+Y21kcV9yZWcs
IG92bC0+cmVncywgRElTUF9SRUdfT1ZMX1JTVCk7DQo+ICAJbXRrX2RkcF93cml0ZShjbWRxX3Br
dCwgMHgwLCAmb3ZsLT5jbWRxX3JlZywgb3ZsLT5yZWdzLCBESVNQX1JFR19PVkxfUlNUKTsNCj4g
QEAgLTM3NCw3ICszOTEsOCBAQCB2b2lkIG10a19vdmxfbGF5ZXJfb2ZmKHN0cnVjdCBkZXZpY2Ug
KmRldiwgdW5zaWduZWQgaW50IGlkeCwNCj4gIAkJICAgICAgRElTUF9SRUdfT1ZMX1JETUFfQ1RS
TChpZHgpKTsNCj4gIH0NCj4gIA0KPiAtc3RhdGljIHVuc2lnbmVkIGludCBvdmxfZm10X2NvbnZl
cnQoc3RydWN0IG10a19kaXNwX292bCAqb3ZsLCB1bnNpZ25lZCBpbnQgZm10KQ0KPiArc3RhdGlj
IHVuc2lnbmVkIGludCBvdmxfZm10X2NvbnZlcnQoc3RydWN0IG10a19kaXNwX292bCAqb3ZsLCB1
bnNpZ25lZCBpbnQgZm10LA0KPiArCQkJCSAgICB1bnNpZ25lZCBpbnQgYmxlbmRfbW9kZSkNCj4g
IHsNCj4gIAkvKiBUaGUgcmV0dXJuIHZhbHVlIGluIHN3aXRjaCAiTUVNX01PREVfSU5QVVRfRk9S
TUFUX1hYWCINCj4gIAkgKiBpcyBkZWZpbmVkIGluIG1lZGlhdGVrIEhXIGRhdGEgc2hlZXQuDQo+
IEBAIC0zOTUsMjIgKzQxMywzMCBAQCBzdGF0aWMgdW5zaWduZWQgaW50IG92bF9mbXRfY29udmVy
dChzdHJ1Y3QgbXRrX2Rpc3Bfb3ZsICpvdmwsIHVuc2lnbmVkIGludCBmbXQpDQo+ICAJY2FzZSBE
Uk1fRk9STUFUX1JHQkE4ODg4Og0KPiAgCWNhc2UgRFJNX0ZPUk1BVF9SR0JYMTAxMDEwMjoNCj4g
IAljYXNlIERSTV9GT1JNQVRfUkdCQTEwMTAxMDI6DQo+IC0JCXJldHVybiBPVkxfQ09OX0NMUkZN
VF9SR0JBODg4ODsNCj4gKwkJcmV0dXJuIGJsZW5kX21vZGUgPT0gRFJNX01PREVfQkxFTkRfQ09W
RVJBR0UgPw0KPiArCQkgICAgICAgT1ZMX0NPTl9DTFJGTVRfUkdCQTg4ODggOg0KPiArCQkgICAg
ICAgT1ZMX0NPTl9DTFJGTVRfUFJHQkE4ODg4Ow0KPiAgCWNhc2UgRFJNX0ZPUk1BVF9CR1JYODg4
ODoNCj4gIAljYXNlIERSTV9GT1JNQVRfQkdSQTg4ODg6DQo+ICAJY2FzZSBEUk1fRk9STUFUX0JH
UlgxMDEwMTAyOg0KPiAgCWNhc2UgRFJNX0ZPUk1BVF9CR1JBMTAxMDEwMjoNCj4gLQkJcmV0dXJu
IE9WTF9DT05fQ0xSRk1UX0JHUkE4ODg4Ow0KPiArCQlyZXR1cm4gYmxlbmRfbW9kZSA9PSBEUk1f
TU9ERV9CTEVORF9DT1ZFUkFHRSA/DQo+ICsJCSAgICAgICBPVkxfQ09OX0NMUkZNVF9CR1JBODg4
OCA6DQo+ICsJCSAgICAgICBPVkxfQ09OX0NMUkZNVF9QQkdSQTg4ODg7DQo+ICAJY2FzZSBEUk1f
Rk9STUFUX1hSR0I4ODg4Og0KPiAgCWNhc2UgRFJNX0ZPUk1BVF9BUkdCODg4ODoNCj4gIAljYXNl
IERSTV9GT1JNQVRfWFJHQjIxMDEwMTA6DQo+ICAJY2FzZSBEUk1fRk9STUFUX0FSR0IyMTAxMDEw
Og0KPiAtCQlyZXR1cm4gT1ZMX0NPTl9DTFJGTVRfQVJHQjg4ODg7DQo+ICsJCXJldHVybiBibGVu
ZF9tb2RlID09IERSTV9NT0RFX0JMRU5EX0NPVkVSQUdFID8NCj4gKwkJICAgICAgIE9WTF9DT05f
Q0xSRk1UX0FSR0I4ODg4IDoNCj4gKwkJICAgICAgIE9WTF9DT05fQ0xSRk1UX1BBUkdCODg4ODsN
Cj4gIAljYXNlIERSTV9GT1JNQVRfWEJHUjg4ODg6DQo+ICAJY2FzZSBEUk1fRk9STUFUX0FCR1I4
ODg4Og0KPiAgCWNhc2UgRFJNX0ZPUk1BVF9YQkdSMjEwMTAxMDoNCj4gIAljYXNlIERSTV9GT1JN
QVRfQUJHUjIxMDEwMTA6DQo+IC0JCXJldHVybiBPVkxfQ09OX0NMUkZNVF9BQkdSODg4ODsNCj4g
KwkJcmV0dXJuIGJsZW5kX21vZGUgPT0gRFJNX01PREVfQkxFTkRfQ09WRVJBR0UgPw0KPiArCQkg
ICAgICAgT1ZMX0NPTl9DTFJGTVRfQUJHUjg4ODggOg0KPiArCQkgICAgICAgT1ZMX0NPTl9DTFJG
TVRfUEFCR1I4ODg4Ow0KPiAgCWNhc2UgRFJNX0ZPUk1BVF9VWVZZOg0KPiAgCQlyZXR1cm4gT1ZM
X0NPTl9DTFJGTVRfVVlWWSB8IE9WTF9DT05fTVRYX1lVVl9UT19SR0I7DQo+ICAJY2FzZSBEUk1f
Rk9STUFUX1lVWVY6DQo+IEBAIC00NTAsNyArNDc2LDcgQEAgdm9pZCBtdGtfb3ZsX2xheWVyX2Nv
bmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCBpZHgsDQo+ICAJCXJldHVybjsN
Cj4gIAl9DQo+ICANCj4gLQljb24gPSBvdmxfZm10X2NvbnZlcnQob3ZsLCBmbXQpOw0KPiArCWNv
biA9IG92bF9mbXRfY29udmVydChvdmwsIGZtdCwgYmxlbmRfbW9kZSk7DQo+ICAJaWYgKHN0YXRl
LT5iYXNlLmZiKSB7DQo+ICAJCWNvbiB8PSBPVkxfQ09OX0FFTjsNCj4gIAkJY29uIHw9IHN0YXRl
LT5iYXNlLmFscGhhICYgT1ZMX0NPTl9BTFBIQTsNCg==

