Return-Path: <linux-kernel+bounces-194276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 718888D395C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 276D9287FCE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B174A15958A;
	Wed, 29 May 2024 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fSBwAtPi";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="IGAgK9ZC"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6FF12E7E;
	Wed, 29 May 2024 14:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716993233; cv=fail; b=E1luiG6WMtLDBB37B+WBf951fajVIUoPu/xAFfo9vdp6mo33LvBgggAWCNvRCivJ2bnOUtNp2tS1ctCkWeuUqHO+phSQXqwBsQJjOHEQ66Il5vHQvsWV4otdjtwMrKPsDGlVmaMj4CeeW/f0yHtLb5gwkriNeJiUIw+zeLfL2Kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716993233; c=relaxed/simple;
	bh=DmxEXqHp+U8/iMruTZPahzCmARxihiokgAzmzRaGDA8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SrhC7K6sUfwrXK+PFOmfAQJ3tC+ziWIaJpQtURTZZyt61kIC26OhtOvcDRUfvBh7hjLEgbR5zyENfCS3G4qjaUJy4uTBbwPqaOsRX68fOVo36eMH6ASxwAGXoa2DyNErYe0YMwhvQe0IKpVCf0IiCLjjpRGxP3WCXIOoe5QitMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=fSBwAtPi; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=IGAgK9ZC; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 72c6b79c1dc811efbfff99f2466cf0b4-20240529
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=DmxEXqHp+U8/iMruTZPahzCmARxihiokgAzmzRaGDA8=;
	b=fSBwAtPiqDLYr6z5iZn2yegD16R6hJEe1vO1/GJyvxMyqDsQVG5kdNs8Mqi7PkCkBTzM2uSauU9fIUl1YTrdbLIrKBMVVyr3obaVPPg+v6VrNV670IZbc6u24gNzgTeZDcGBnaEt8S1edKb8GBTLrT88vHOiSJm2X4i8KC0lHlM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:8f03b671-6629-48c9-9f9e-60c8f21b7af3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:dee8f787-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 72c6b79c1dc811efbfff99f2466cf0b4-20240529
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1360776376; Wed, 29 May 2024 22:33:42 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 29 May 2024 22:33:40 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 29 May 2024 22:33:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ql7Mhsp6wjps3XdVOvhhp9yChbRje2sVDm6UYi7pBUsDpiTxDHmN4eF/1Uf903EY4qeTCrnDl2H8PW63smAXp1ZO3c+HhrCgANnOfg/hdlkpSO9TLdTd4y1Qa8R5adLoOqeYTKum59IvK2XZvpC5SNdMBY/smXVjDQOxxl+CSKN/2DY7xYcl920Ue75GFBHXK5xfLlFZZXfPsLRzE6AlwUUaIZW4nrC4XVHdEdtIG8Ma8fvYPW8wolUMpYaYfACBWyPBAKsPvXMPyfpu8SRsLAc52wrCp7/5VXmiubFvgg8cFfU7UcN/I51mS7oXmuAygKM+1It369r1g9IHcqVNmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmxEXqHp+U8/iMruTZPahzCmARxihiokgAzmzRaGDA8=;
 b=fetvIFHL7rJQX60q9TKdY2bIbqiFw2/dUp8S54ZiT5+t/LpYg16yjb40kQn90dicyzh8zYQLS06Z6sSk0h1czD7hefr81JS57XRGAuUqfHaDjONa+4Boa8BcQM1zczYdMJCZLosgfl90BElq3pym28lW+lhpi213BA34SRX8ncykFv6LYbJtjy58eJxPZXb18ln2odx3I9Dk1eFHBK1Qg7TeSsvKBw33v3+nK67YEaakg/+6zeVHv5dwy+twfqBCC9Qm1OOa5W4ZplwluU7aVGX4CSpmCl2Eo52YERvtU9Ey41oiSFwNye1dRgNkJLJGjkmFhXW1i+sGdBQN/l9g8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmxEXqHp+U8/iMruTZPahzCmARxihiokgAzmzRaGDA8=;
 b=IGAgK9ZCB/JJpn+KIo9F2g0/D0+4g28IMq2BoghDegIYFvTsHRUPYsNEcQAdLHIpDFHhPBj5FGZ4o8oCCH8GP/HKyzDGl6C+aYgN7w21+nWmzntyqa3MjL5xk4bbm52WFaO6kAYy3Mc4IOcaYBHz4+Hzx+BHjEo4ep9rlIgg1Gg=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SEYPR03MB6796.apcprd03.prod.outlook.com (2603:1096:101:8b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.16; Wed, 29 May
 2024 14:33:37 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%7]) with mapi id 15.20.7633.001; Wed, 29 May 2024
 14:33:37 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH RESEND, v6 6/8] mailbox: mediatek: Add CMDQ secure mailbox
 driver
Thread-Topic: [PATCH RESEND, v6 6/8] mailbox: mediatek: Add CMDQ secure
 mailbox driver
Thread-Index: AQHasKV/cRJMjExS/0SyyRFsiJz8gLGuSRUA
Date: Wed, 29 May 2024 14:33:37 +0000
Message-ID: <dc20f80a0079dbfa832a751323752f602e559822.camel@mediatek.com>
References: <20240526144443.14345-1-jason-jh.lin@mediatek.com>
	 <20240526144443.14345-7-jason-jh.lin@mediatek.com>
	 <5ce30bf52a4f2e4f6f76d0a4c25a08a45f14b6fe.camel@mediatek.com>
In-Reply-To: <5ce30bf52a4f2e4f6f76d0a4c25a08a45f14b6fe.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SEYPR03MB6796:EE_
x-ms-office365-filtering-correlation-id: a8417ce8-c9cc-4045-2954-08dc7fec53ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?K3hmam44VEluZnpWMUhiWWQ5N0xoNWtScHNWN0xJb29jZGFER1VkbU5HN2Ja?=
 =?utf-8?B?VWZJeG80ZlFZOTlURHE3eW8xa2U0THJPZ1ZzR1BtQ1dMZkxBaGR5d2xwRTlo?=
 =?utf-8?B?bTZLcEZZZEdLcWxWZEZYaU5sLzNNRDNNZGJ2bCtrUTROK3hCTTg0N0ZJeTR5?=
 =?utf-8?B?RC9pak11dHQxMkszUU1aQ1dndVBRa2JpcCsxbDZ1V2RkcjVQWGRlNEt2SUhw?=
 =?utf-8?B?SmpzdnQ2K3lFVFg4T0JNbXI4ZXZCdVhaMkdlalpyTXZYbEp2ZlNrTnhJYVNh?=
 =?utf-8?B?K1U5TnNmTDl3V0VUK0NDU0dkSHBDQTc5amRaeXh3ZTcwRVpHdWNQanVsU1U1?=
 =?utf-8?B?U3BCVTB5cWxGV0pkbXpLRFZISEdDRXhVMXVhbDBQeXo0YVJleGJwYStucTJn?=
 =?utf-8?B?UkpvTU04eEVWTGw3SmRrZG5DR0VSNm9tM0FpVTIyYUxjcXNSVDY0bFd0SjA4?=
 =?utf-8?B?RDhHLzVhUk9mUmVGb0NGQ0pyMmhwTm13TnQ0K0lvd3ljV0xQVy9uTmgvVE9K?=
 =?utf-8?B?b0xHSmxMTWVGbmszVmppQ3cweHI3bFNpSUNuNlpZbnpZZXZ2R0MxQWU4YkRy?=
 =?utf-8?B?cEo2cjR6Nk1UN2grWEoyNTlvdDdrWjkrcHZlS2JWcElDMUMxK1FrL1UvaWtk?=
 =?utf-8?B?T040dVJ6RjFLTTA3VndUVjRCQVlMc2NFdDJDZmxxQW1yT3JjN0JWQ2lXeER2?=
 =?utf-8?B?YWNCUzdwQ0ZabGdaRVNMWCtoOU9mUzZVcHphSzd6dE83aDJRejJmY0tiV0px?=
 =?utf-8?B?LzExYVlHMkpEQ1RReE1OeERPelBzSjRtbzh4b3pMYWFWcVlXN0phc0g0U3Uy?=
 =?utf-8?B?TFZYSmFJQ0ZOOXBLc1NLZmVaT1UyRVFHQWpTd2pLVWxlVnNPMHBpSE0yWmVC?=
 =?utf-8?B?NjY4aXFlWjhsV3BSMUxENWlTdWZtU05HZDFha1JRVkxwVFJmRE9DNTNzb0gz?=
 =?utf-8?B?cGYvbmlhME8zVW9YQXczTVp3eGI5RUtyMU41aDkrSWNuSDZVZTlnZFJmUHhv?=
 =?utf-8?B?QzZsRTIzL1JMcXFjbW42bTBSNFVFNVJOTXlzaHZYejdleDlOWG43UUYwQjUw?=
 =?utf-8?B?SWVhSzBZWUk3OHRHVVJCQnhmYUk1ckFpU3N4b0pzKzh4ZDYzeXFqVldGRThv?=
 =?utf-8?B?NFQzT0dXV0Q4bElYcWF4cW02cXJ1TngvS1FjWjQ3VldEbUdBbWJQcldqdUti?=
 =?utf-8?B?MnUwRFcrSlVTTnJ4dVd5WUI4SFVuV2t4VDdiRGEzenBQd2l4U3dvSDYxMHlm?=
 =?utf-8?B?bkVDS0tBS1k0NDJWS3VkaUJoMG14WVJ4YllWNVcrbUpZN1YvTk9qaWppbk9D?=
 =?utf-8?B?cy9Wb2VMU1A5UUp6SFhqczYyMzk2NkcvTlF4QmZCeldvT3BBcWhTbVJHNURm?=
 =?utf-8?B?VkZpWmlGamE0QkVMQ01OWlRwT00vbVVDaVBXekdXdW9taHNYcU82dmZIbC9n?=
 =?utf-8?B?VjR5SXZSVnU4TFdrNXFCNHNBVi9ub1hYZGZORFVRYkoreS90WlpwUWtEYVR3?=
 =?utf-8?B?dFhOeGFIWHFOUlFQeWhCMDl0c3RyWEFISk9MR2wvMUVtY050Mmw4anhVc3Zh?=
 =?utf-8?B?UVVCd1NuOW8yYVpycmN2cEZOV1BLSllKM0lXQ0ZSblI1eW9hKzhhSEJ6NjFN?=
 =?utf-8?B?TUdvUmErc3BDa2xkSFlrQktpZXRqREp3SXJaMWdEcjlWTWVXdTZ0ZE1FQWhF?=
 =?utf-8?B?a3dxL01lOHFRRm93ZXlmbzNVOStOVkNvQjhMTTdoNDdYQjVkcHN4OFZyVE1B?=
 =?utf-8?B?cTMzaXVIY1dKa0R4STJuUGQwZzdia0NmbnZnYyt3TkpQcThkcjVVakQ1M3cv?=
 =?utf-8?B?ODBzN3pHNzZ3OTFHMHE3Zz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDU5NVZvdmN6ekhzQmNzQ0JYWDdMOS9IdEYzZFN0ZVNMNjRVL2JxcklKUHRV?=
 =?utf-8?B?WStjT3MxQUlOMGxvWmlNUFRGaWpTbEpJWTV3cU1kTmdLcHU0OWRYQTkwSTNR?=
 =?utf-8?B?ditLQ2lyeXhQNkwyU3dReEcrVENSV0xhdW9MbzllZVpIOWlncEw0c1QxN3Yx?=
 =?utf-8?B?cVM2cnBvU1NzeTlCd1NIenVKYnNVeHZYbWhpT0M2YW1FQ1lCOFYxU2FHUVBz?=
 =?utf-8?B?S0RndUdOV1NBZGNPZks2K1V6dXd2UEhVd3VtdytkWk5aSUJWM3N6dk42WUx4?=
 =?utf-8?B?ZDJ5dFUxeWd2OVVRTGcyaHRuYkdHM2lHdEUvbnA3U1dsVXZSck5uOS9HNU1m?=
 =?utf-8?B?b25zMDk2UlhoMG1heUhmRERiTDVuSGJzaWNEVVJ1WFVkdmIzcVRGSWZaWXdF?=
 =?utf-8?B?RTJLS055c0xxdk84MU9iUmEvQ003bEF1QW9nNzdacHEwSzFXMEZUOWxVT1Nq?=
 =?utf-8?B?TzM1bXlhZ1QzWFh2ZHpkMVUraVVIQVJ2TjNFd3JmTzZ6WmtTK1hEamhpeWlq?=
 =?utf-8?B?ZVNkZUN4S1JDUVlHZUNiT1FwYTNDOWViaXNLdTZoNzVKWURVcXFyQlAyNXFV?=
 =?utf-8?B?cGs2WEgrUlRRRjhQYWREZlJyR3F1UDZFNG9iK3JFZW53OWQycFhFSnZqNHdC?=
 =?utf-8?B?VkdYU3pVZlcrRUUyN1UyR2VXdnFEdDgzclhSUWxobmpMQkpvSlVuencrN25N?=
 =?utf-8?B?aE1SMzRsNW9WQS9YY1JVbStzQ2RwTnZuN2JSZkRxamRCU2xJWDhiT2M3ZmJw?=
 =?utf-8?B?SUtwL2F3ZnFLRjdBV0h2Y0dvV1lMMStxaWlnZ01tbGhzaDJHSEpYeERCRWxi?=
 =?utf-8?B?cnBSM1hHcytFQk1IVTdPVEM5V3h3WVYrOUU4MUovTkZ3OTBldm5HUEFjbDdC?=
 =?utf-8?B?a1RWck4weDJ6OTJ5b2FNRDhuaXVHNFZ6ZGJya0Y4OFpkR0dLOERBVGpTeTFk?=
 =?utf-8?B?STFBbmd1bFNqek1pZVNDTFJXMnAvVkV4aTc2akRMcEIvQ21Id0tqRGFnWVdM?=
 =?utf-8?B?cW9LNitHZ2pOK2JHTUJNWDVpbE4wRjNVLzBPRkYvcUpHSFZrWjVPU0ExZUZl?=
 =?utf-8?B?SHduWUcxUE44Zlo2aXVSSTBRdjVFVDkwQ0JJbFhTQTk0U0FoTlFWeXBDc3hC?=
 =?utf-8?B?aG1ERXlRb0t5RTVMWThvMU1MNFVzZmRYSHFIMURscWlYaml2VFpyL0RuV0dj?=
 =?utf-8?B?RHdLZGZDcGpOa28zay9Kb21YVktRd2FUandiWm1UZk85NHdpL0YyWlFHaGNN?=
 =?utf-8?B?dHpQQ3gwdWtXa0IxZXJGSUl4eENveUd4cHlNTXJXVktuRGtZd3Q1TTBYUUgz?=
 =?utf-8?B?Nkxyd3BPNUFlVU5zUG5mNGsyOGNqdjRQZVNSb0N0dlg0UWVoR2pUTEorcWVm?=
 =?utf-8?B?LzBKWHM4WXNBZ01sSWFRNExuTFVxWlNma3cwUi9wOFhoQzdrUDllZTdjekI4?=
 =?utf-8?B?bnRIcUVHRFdocnNDOVd1b2o4TmFWSm5OdzRpT0tydkFTd1pBMWUzTi93UTlP?=
 =?utf-8?B?bFR2THUxc0lic0ZpeUI5eEFGRXl0RHNFcERqUzZ1eHJlcGhFUmFHQjE2Vlhp?=
 =?utf-8?B?SUJ0OE9BYUNmelRYNzlYOWR3UUYvMExFMFRvVEZQWUE3MW11VGlycUZic1d6?=
 =?utf-8?B?VkhBUEdGVTVtRWwzM0lVSHIzQ3ltdC9OeG5BK2lZL2FZWS83VUZWcHdKTENt?=
 =?utf-8?B?T2NNNGZKbnpQTmkyMnJWR041M2o5bHV3QXBaOEhmR0ZNQkN5MHp1TDUySnMz?=
 =?utf-8?B?MFZXdkliTmNzajU2djhRN2JVVktHQkpXcGpGbjNIcEIyYlBRcnRQN3owa2kw?=
 =?utf-8?B?VVFpME5oSzMycHQxc0hXOTJNL2s0dzlMaFdkWjRrV0NQcGpWSWlxT1FTekJz?=
 =?utf-8?B?dGpKU0hNM1I0Yjd2dW0rOEFEU2VqRmhUQUh3ZGNHdmpVc2tOd1FJcGViZWxZ?=
 =?utf-8?B?SENGZ0pseFdkSFUwankxNlpzSXRIQktBVnlsbkN4Z3hqc28yejl3S0VMUGFD?=
 =?utf-8?B?T0hoY29nZG0wRmpEWXJvTXRIL0VkVDg0U3JKdE9jalJJOHRaTzMwTExxT3du?=
 =?utf-8?B?YlQ5YXVEUmYyVUlZQUNSeUN2emUvM2NpcjFCdHBKWmhLZ3FvMk5PYS9wWENK?=
 =?utf-8?B?djhjU1hnOXFsSnlETldWZHBObnZjaHl1dXhSK1F1S3RjOFlTY2ROOVlOTWpY?=
 =?utf-8?B?dmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5BB86A183880C48BC3782F3D1F232E0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8417ce8-c9cc-4045-2954-08dc7fec53ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 14:33:37.4186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vWJPlxlhybuKSKB6tNnk49zRZKoYjicueRRafzY6x6/+CKCJ2QS8u3Ez1A17w17d0YzLlDwGykrh9x4oAn24/FOGZ1nHfbDD8FMaccqNF80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6796
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--20.532100-8.000000
X-TMASE-MatchedRID: VfovoVrt/oYOwH4pD14DsPHkpkyUphL9fjJOgArMOCb3bBqxmjinTbs0
	9RsYKeKEiUqxWFzqa/9QGF7v4Up8Fw9FV6kNYiPHbc297PAGtWaQoBr+SFneJOfyso7l4CECNGR
	pRnc8uefONwCKwD2eBbkK4EPjG7pLvkVC8Xcyk7UmEURBmKrZlPngX/aL8PCNTgrQgyTabcbU00
	xRT8R7/mvKfnxrioXQXv3Br7NehX3p+5uxX4D6T3V7tdtvoibafkSt9GqmKVUA6s2mIXI3kP4ZA
	Usty2ENUySZEu6rYVqfb6bl1YfU90L9tcyTZdAsgxsfzkNRlfLdB/CxWTRRuyUIayx+Skid
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--20.532100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	850D670209E5A42AB2E209C581801795B764407DBDA7C67731A4A1DC9C5FBA002000:8

SGkgQ0ssDQoNCk9uIFR1ZSwgMjAyNC0wNS0yOCBhdCAwMjoxOSArMDAwMCwgQ0sgSHUgKOiDoeS/
iuWFiSkgd3JvdGU6DQo+IE9uIFN1biwgMjAyNC0wNS0yNiBhdCAyMjo0NCArMDgwMCwgSmFzb24t
SkguTGluIHdyb3RlOg0KPiA+IFRvIHN1cHBvcnQgc2VjdXJlIHZpZGVvIHBhdGggZmVhdHVyZSwg
R0NFIGhhdmUgdG8gcmVhZC93cml0ZQ0KPiA+IHJlZ2lzdGdlcnMNCj4gPiBpbiB0aGUgc2VjdXJl
IHdvcmxkLiBHQ0Ugd2lsbCBlbmFibGUgdGhlIHNlY3VyZSBhY2Nlc3MgcGVybWlzc2lvbg0KPiA+
IHRvIHRoZQ0KPiA+IEhXIHdobyB3YW50cyB0byBhY2Nlc3MgdGhlIHNlY3VyZSBjb250ZW50IGJ1
ZmZlci4NCj4gPiANCj4gPiBBZGQgQ01EUSBzZWN1cmUgbWFpbGJveCBkcml2ZXIgdG8gbWFrZSBD
TURRIGNsaWVudCB1c2VyIGlzIGFibGUgdG8NCj4gPiBzZW5kaW5nIHRoZWlyIEhXIHNldHRpbmdz
IHRvIHRoZSBzZWN1cmUgd29ybGQuIFNvIHRoYXQgR0NFIGNhbg0KPiA+IGV4ZWN1dGUNCj4gPiBh
bGwgaW5zdHJ1Y3Rpb25zIHRvIGNvbmZpZ3VyZSBIVyBpbiB0aGUgc2VjdXJlIHdvcmxkLg0KPiA+
IA0KPiA+IFRPRE86DQo+ID4gMS4gU3F1YXNoIGNtZHFfc2VjX3Rhc2tfZXhlY193b3JrKCkgaW50
byBjbWRxX3NlY19tYm94X3NlbmRfZGF0YSgpLg0KPiA+IDIuIENhbGwgaW50byBURUUgdG8gcXVl
cnkgY29va2llIGluc3RlYWQgb2YgdXNpbmcgc2hhcmVkIG1lbW9yeSBpbg0KPiA+ICAgIGNtZHFf
c2VjX2dldF9jb29raWUoKS4NCj4gPiAzLiBSZWdpc3RlciBzaGFyZWQgbWVtb3J5IGFzIGNvbW1h
bmQgYnVmZmVyIGluc3RlYWQgb2YgY29weWluZw0KPiA+IG5vcm1hbA0KPiA+ICAgIGNvbW1hbmQg
YnVmZmVyIHRvIElXQyBzaGFyZWQgbWVtb3J5Lg0KPiA+IDQuIFVzZSBTT0ZUREVQIHRvIG1ha2Ug
Y21kcV9zZWNfcHJvYmUgbGF0ZXIgdGhhbiBPUFRFRSBsb2FkZWQgYW5kDQo+ID4gdGhlbg0KPiA+
ICAgIG1vdmUgY21kcV9zZWNfc2Vzc2lvbl9pbml0IGludG8gY21kcV9zZWNfcHJvYmUoKS4NCj4g
PiA1LiBSZW1vdmUgdGltZW91dCBkZXRlY3Rpb24gaW4gY21kcV9zZWNfc2Vzc2lvbl9zZW5kKCku
DQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVk
aWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1
bmdAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiANCj4gW3NuaXBdDQo+IA0KPiA+ICtzdGF0aWMg
dm9pZCBjbWRxX3NlY19pcnFfbm90aWZ5X3dvcmsoc3RydWN0IHdvcmtfc3RydWN0DQo+ID4gKndv
cmtfaXRlbSkNCj4gPiArew0KPiA+ICsJc3RydWN0IGNtZHFfc2VjICpjbWRxID0gY29udGFpbmVy
X29mKHdvcmtfaXRlbSwgc3RydWN0DQo+ID4gY21kcV9zZWMsIGlycV9ub3RpZnlfd29yayk7DQo+
ID4gKwlpbnQgaTsNCj4gPiArDQo+ID4gKwltdXRleF9sb2NrKCZjbWRxLT5leGVjX2xvY2spOw0K
PiA+ICsNCj4gPiArCWZvciAoaSA9IDA7IGkgPD0gY21kcS0+cGRhdGEtPnNlY3VyZV90aHJlYWRf
bnI7IGkrKykgew0KPiA+ICsJCXN0cnVjdCBjbWRxX3NlY190aHJlYWQgKnNlY190aHJlYWQgPSAm
Y21kcS0NCj4gPiA+c2VjX3RocmVhZFtpXTsNCj4gPiArCQl1MzIgY29va2llID0gY21kcV9zZWNf
Z2V0X2Nvb2tpZShjbWRxLCBzZWNfdGhyZWFkLQ0KPiA+ID5pZHgpOw0KPiANCj4gSSBwcmVmZXIg
dG8gZ2V0IGN1cnJlbnQgcGEgaW5zdGVhZCBvZiBjb29raWUsIGJ1dCB0aGUgY3VycmVudCBwYSBp
cw0KPiBtYXBwZWQgZnJvbSBzZWN1cmUgcGFja2V0IHBhIHRvIG5vcm1hbCBwYWNrZXQgcGEuDQo+
IElmIHNvbWV0aGluZyB3cm9uZywgbm9ybWFsIHdvcmxkIGNvdWxkIGtub3cgd2hlcmUgR0NFIGlz
IHN0YWxsZWQuIEFuZA0KPiB0aGlzIGlzIGhvdyBub3JtYWwgdGhyZWFkIGlycSBoYW5kbGVyIGRv
ZXMuDQo+IFdlIGNvdWxkIHVzZSBvbmUgbWV0aG9kIGZvciBib3RoIG5vcm1hbCB0aHJlYWQgYW5k
IHNlY3VyZSB0aHJlYWQuDQo+IFRoaXMgaXMgZWFzaWVyIHRvIG1haW50YWluIGNvZGUuDQo+IA0K
SSdsbCB0cnkgdG8gY2hhbmdlIGNvb2tpZSB0byBjbWQgYnVmZmVyIHBhIGFuZCBxdWVyeSBpdCBm
cm9tIHNlY3VyZQ0Kd29ybGQuDQoNClJlZ2FyZHMsDQpKYXNvbi1KSC5MaW4NCg0KPiBSZWdhcmRz
LA0KPiBDSw0KPiANCj4gPiArDQo+ID4gKwkJaWYgKGNvb2tpZSA8IHNlY190aHJlYWQtPndhaXRf
Y29va2llIHx8ICFzZWNfdGhyZWFkLQ0KPiA+ID50YXNrX2NudCkNCj4gPiArCQkJY29udGludWU7
DQo+ID4gKw0KPiA+ICsJCWNtZHFfc2VjX2lycV9oYW5kbGVyKHNlY190aHJlYWQsIGNvb2tpZSwg
MCk7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJbXV0ZXhfdW5sb2NrKCZjbWRxLT5leGVjX2xvY2sp
Ow0KPiA+ICt9DQo+ID4gKw0K

