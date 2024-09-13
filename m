Return-Path: <linux-kernel+bounces-327528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C0A977729
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 04:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 275042849B7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 02:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5458B1D2F58;
	Fri, 13 Sep 2024 02:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PW8AEH+T";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="aR5aKWT9"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151871B12D8
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 02:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726196195; cv=fail; b=YSgwgG1MSPPbah6zPaRd9TjKP1/P1RKgc6H7rWahRaFzlvjJj8TaQ3SIFQPUwGSn+zXHbn9vzhBnibcWG5MbYfgQtMdZZ9yYeMKJG95Nh3oPr2sWmQbS5/r5WqYJlc9MBYkri6Z4ZQf/SCo16uTMfvhtGhkqpZYJr9TIb9Oy7jU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726196195; c=relaxed/simple;
	bh=7tGKL5KLceCnafwr7E1lqtZjezfTVfxSZuS9mViAe0U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uqUMalBXg1YJrWqmSj8O7wO1CqX5SSyVyoCvOeARKClHu4cbbpHV1nMtlm/IOHZxcdlz9/T2IlDojnv5YKxMfj/VzVCaZoJqaLIKBAssb6xtaMfoZYA9CUHUxcpWPiE9SmvdnfP0JvaJZKH8I/IyKgS8fiNWL9w3DwTaYr/NVtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=PW8AEH+T; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=aR5aKWT9; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c4c94bac717b11ef8b96093e013ec31c-20240913
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=7tGKL5KLceCnafwr7E1lqtZjezfTVfxSZuS9mViAe0U=;
	b=PW8AEH+TEcVzQ7V+p6ET1MSRI+Ia6U1aUagOD7nsPAud8NVFLQ0DMLaLTkMnEoMyqDDIqa0pRJ5K+BFOfWKLE5CYSisLlwPr1XSIPr/Kv7afEhkL27lC0XOLMMR1KdqBO7/a4w6SBF1XgoG94h38rwOQSdzMg+Sovne/WrB5F8M=;
X-CID-CACHE: Type:Local,Time:202409131056+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:3114184e-d12f-4e5a-98fd-c00d6b46032f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:031df1b6-8c4d-4743-b649-83c6f3b849d4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-UUID: c4c94bac717b11ef8b96093e013ec31c-20240913
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1510995904; Fri, 13 Sep 2024 10:56:26 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 13 Sep 2024 10:56:25 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 13 Sep 2024 10:56:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y9sV+snw6An4U9Bhd4WsXTKOyGLZ3Ity5HuwFViRw7MC9P0M5mFeeeyAknS1joy6SEGnzPlOj31cEAmZtQm5aRzIS5lV2eKg0Fxpu0Be4dc5riSWO6OweJF9lEQv8st8n2c6QtM4qB8anW9INbpPi7JJyCxmP+hc3lklLTir5bi+8O6cCK3fXBltS8vrvdfRnTPJ1TEywAy2EMhDZyZrn/ElNf7alYXA6wWAkMaLPMG54xWXut2PpGo+X4GIYh9TMwhSGy34pG1keqLw3zua+B6j9rUEH2q2iwPkow4TFoioolEspnVvHDDoPFytAC4vHWtqqEI1z5O2lpS0y1RQXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tGKL5KLceCnafwr7E1lqtZjezfTVfxSZuS9mViAe0U=;
 b=WlRmY3VrQkOV5qzfBWvKU+qudZrwqO0B5ATY+4H2vqN//kO9aplbO6KyHi9sHvp2f8WLR+F6JT0Bwrj86NPgfUJnd9qITsPRRZL5JDDIlfWjHc1H/CAsNbGzpt3OINxuIEonQQXntUH7lRDC44qTurRWOBIq+k8vcl9XB/0D278TAB/u17cy3HwrDVYVsSyzLKjD105QtAiBxoQasD7/3pmI1fUwXHZMUz4a1LZMiPG+uEwpYH/yKsFAXa1/oppGhtLnByKO45IMEovFsrkdEYIQOmnfZtq0ygnzzH1h9UhS8HDavIM4e6UOetAGnQs5p9wYBRUk3HHV8qilds7Y7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tGKL5KLceCnafwr7E1lqtZjezfTVfxSZuS9mViAe0U=;
 b=aR5aKWT9mPtL+HxpIEZ0jHyb2GPrmBt6U4K6DaqAMroA71WELqQuaR115ERV/u74Rc92vOncUPhniwqQzNpiHFkscfpIM27hnYBDk916Zy+3P3t4S38OM89d4ilbGrxUPpwAELcskdI4I5wfFcqbiQOinzkjX7w+pvKWpFV4sps=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYZPR03MB8281.apcprd03.prod.outlook.com (2603:1096:405:20::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Fri, 13 Sep
 2024 02:56:22 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%5]) with mapi id 15.20.7939.022; Fri, 13 Sep 2024
 02:56:21 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	=?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"alpernebiyasak@gmail.com" <alpernebiyasak@gmail.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"wenst@chromium.org" <wenst@chromium.org>, "daniel@ffwll.ch"
	<daniel@ffwll.ch>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"shawn.sung@mediatek.corp-partner.google.com"
	<shawn.sung@mediatek.corp-partner.google.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "airlied@gmail.com"
	<airlied@gmail.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v4 0/5] Support alpha blending in MTK display driver
Thread-Topic: [PATCH v4 0/5] Support alpha blending in MTK display driver
Thread-Index: AQHbBVKAS5jCWCgqbUSRHyfLeyjMZrJU7OqAgAAZdQA=
Date: Fri, 13 Sep 2024 02:56:21 +0000
Message-ID: <13f6dbc5d460e746352f68b001e85f870c89993d.camel@mediatek.com>
References: <20240717-alpha-blending-v4-0-4b1c806c0749@mediatek.com>
	 <CAAOTY_8ThuusfHk9Gd5pFP8VhJkG2seuJmkFiruK1rPQFZGBzg@mail.gmail.com>
	 <6c9b7f85-f92d-44ed-ae9d-00f6d55ea614@gmail.com>
	 <a2cf4e9b9c3343a7398521760934f1740505aa13.camel@mediatek.com>
In-Reply-To: <a2cf4e9b9c3343a7398521760934f1740505aa13.camel@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYZPR03MB8281:EE_
x-ms-office365-filtering-correlation-id: 1f63a6f4-7888-4909-84d7-08dcd39fa5fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Q1RUYUlrc29ORzYvS1dNOUdDbXJGdjNuQXhtZkY4OU9qZlNVaUZ5RXBEcFVJ?=
 =?utf-8?B?MDBUcGI4QWVaTnlZZk1MTy9WVS90Zkd1ekpUdWZxcmtHekoyWEhYRVRXYUE1?=
 =?utf-8?B?WU51bHY5d2lqZDNvSVozODNUelord21hQ1Bjd0pIemFCR2I0aU1oQlgyM2lq?=
 =?utf-8?B?VzdDL0JTWncvZnRjZVZkaFpQVlVScm1SOTdmdWpXT3NjSVBobS9LUlkwVWhV?=
 =?utf-8?B?TE9uenp5aEh3SnllUFZBTjFIUXFPSnk1UnZZYWxseXo5aUJuNjg0Q2tpcXlK?=
 =?utf-8?B?YjlGYWJ1cHR0bTZyVEJ2Q2VmMjByQUROd2I3NDFwQS96Y1M0NlAzNjJxL0s5?=
 =?utf-8?B?bmZ4WXdReHlRdlJHOHBCN2IzajU2Nm9NOTdvOWFlNW9PRWxXYjA0bE9zbnc1?=
 =?utf-8?B?UjNlTDY2YzBBUG5QdENTVEluS01Oc09qOFNCaUNuei9IRGV2eHFKZmI2WUFW?=
 =?utf-8?B?ZFd5YVNLZStOMzM1YWdBSGlhL1E0V2Y3d1p6MDlldmx1NXJNYmd5SWU3bEJk?=
 =?utf-8?B?L3RKMFlPMm4wVDBDMGZVbHpUQ0RmQUF3Vk1UTXpJUFlxRUoraG5EWWJNc0I5?=
 =?utf-8?B?Zk1xUWp6c05NTFVWQ04raWlPZUJvODZ5Y3c2a0l0Ni80SC9RMUkybDRibUxW?=
 =?utf-8?B?OCs0OW1LeFhBOGZObFU1UVBSQW54UEhvak9IS0x1RW9RTXBNTWxnWDJXUmFi?=
 =?utf-8?B?emVkcW9Nc2FySzkvSUpXeitmOFI1ZFNoQzVQd3NyRWxCSG1xT2h5L1ZJRVh0?=
 =?utf-8?B?eXBjKzcrL2JRcGNRTFZYRTgwRyt2T0VrOXFPTTlQcDdTSUtoVWRqM2FnWnlS?=
 =?utf-8?B?SGxPamtGWnU1djJSTC94QkVBZzJzUUR6LzdPR3NuUVF5NkkvQkRHYWQweWVI?=
 =?utf-8?B?anN5YmIwR0JWd1JqOGhWcndqeHp3S2VMNXVHU2tVSFc1R3RLZk0wblFNV1Z2?=
 =?utf-8?B?Z1NnYkJrTEprN0VCQmN2T2tvS3FyZXY3OUdmZHI3dGZLYVhyQzkxRWdFNDJT?=
 =?utf-8?B?TEVnZ205Q3dVZFJyTndRZC9kdStqK2pIQWNOeFBZdEFvYk9BS05oNEdLbHp1?=
 =?utf-8?B?cGxDV3duZVFaVzRvNXJ2WWNyc2pSV2d4MU5rYmxlTG80NnByM1JSb3k4cDho?=
 =?utf-8?B?OHc4NmxDYVJsVm1hbGFGTFJjZHhpTWJFdHpsb21KcVhqNXNsU01mOG9HMGtK?=
 =?utf-8?B?clAyMVpMNk8rQ1FXNFlkZGJMbVhtV0l3bWxPaGdRcmFCUkVodVJSbTVNb1J2?=
 =?utf-8?B?c2M1a0h3VURhajR0S2pJbmhRc1JETzRCR1lPbkxyUFkrNzhJSlJkbjQxVG5L?=
 =?utf-8?B?Q250M3p2YlM3UjEvSFNsWVZHa2xaOVBKdkFiRm9yS09yQzVkWnZhcCtidlI0?=
 =?utf-8?B?MWtKS3oxUWNBZ1VENXUrSzdUL2tHQVpYTjc3WmNnamNqeitqdWo5K3JVOTly?=
 =?utf-8?B?Yk02SFBDNkRNS2kyblB1bTJDNEtqRElVZVdZaUtMU05kVnJTV0hrVzlDd0Yx?=
 =?utf-8?B?YlcrM2U0VWRqbTNFZFpNZmk4SDU3czByZE5aRE4xNjRrVDArYmFxaEZQam5F?=
 =?utf-8?B?V3ZqQ1JmT0ZweVRzNDVlQVhUR2tMU1dQUTBJWW9sQ1Y4QStWN1FMMDIxbzFh?=
 =?utf-8?B?Mkl4UzZuTnhOcmRxQlBndzVTaWNmMXhlWFNMc2hSK2crOXdiZUc2M29Bd0pq?=
 =?utf-8?B?T1JlQUdNcWJ3MjQ0cUhERGNFQjZWanZTTkxtcEExZThiQi90SHpmSDc2RUZS?=
 =?utf-8?B?WW5HREl1R0VHVkFIQk85U05ITWZSK08wRnhEZHdwVUdSVGZvbFNENXFjNkNr?=
 =?utf-8?Q?90gsUgb/DlSkEVNJ676/vj10jqs2GUDrf9z9U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWFzcXhjcURaUDZnVDhxSEJyL09xNWFZOGFqVWEyckMvRTlLUTVLekR1Vmxk?=
 =?utf-8?B?TnFRaEd5ak43WU1YaFYzYllhMk5CYTc5M2NYRHoyenJIVktpNXZicC95NDJU?=
 =?utf-8?B?T2VmM25JemVjQ3lDYzY2QWRpbGdhUG1XV2hUckFXSTFHdUZJY1kwWTZoeW1U?=
 =?utf-8?B?RVNFSllsUE0vS3RZS2FVamJDR2Q1V3R2L3psV2NzVWxHY3VqZGd0aWR3R2J4?=
 =?utf-8?B?WUIwOGdQSWEyTnNDUmEydGxsUDVDMU1kTnVUb0VwcEJ5MG85bTN6S1E4ajZQ?=
 =?utf-8?B?UnQxMUVHWnNMYzFxQ1d6eFdFd1ZlTW85VUtkckZyVHMxRHNUQWRIZi8zMTkz?=
 =?utf-8?B?YWZCWDJQNTJucHAwQ3F2SHBjdERxcmpsYzJuYXh1aHBOcGU1T25kLzdIcUl2?=
 =?utf-8?B?MStDM0NkOWVNN2E3MlpyZFpsYzV2cENEWEFYWlVmQm5icnNpbmpEWjBaQTla?=
 =?utf-8?B?RXRZSHd5ZTRPb0hkQ1F1UElXSWE0aVRvdmE1MVlIckxXaDRsZ3F4ZVNHQWRC?=
 =?utf-8?B?eWRnOHIyRDlram10S2F3SEJLSGdKeDZacmlBS3p3eGx6aEd4ZmVXeHhTK1NB?=
 =?utf-8?B?YnFuOGROY0dyeHBka0NYS2ppU3JCWUw0UTFUWWRxd204VDJoWEFqNERtcXBu?=
 =?utf-8?B?a2RyUmNmQmhQaWhTVmM1dVVZQk9mdklEdXZab0tIL2RHbFBYbnpabjk5ZnlJ?=
 =?utf-8?B?UkVyVzNRUnZBZUZiRHJNczZhTTFCam1RZTFOT0ZaN24xQzBvWmxYRlh5aUxh?=
 =?utf-8?B?dUFiVENweFljUW1ROU83d0U1RGxObVZ6bXd0eHFselhQb3kvTmVwc1hqUmMy?=
 =?utf-8?B?dEx2MHpYVXUzVDRWSmEzMC9Idk5YZkorMDRsSFBHWHFPNUhPckhPM0p0MUdt?=
 =?utf-8?B?eW01SXhsalc1QmhhWjNDZ0dtSHZCQnJ0ZlZFR2xKUmJ4SDJCT3V0SFR0KzlV?=
 =?utf-8?B?aHEwOUZ1dlVUdjdqaVFMWEp2SDBPOVBvL0doNmtTSVZNd2hXVkFnakxBd01R?=
 =?utf-8?B?TkJRT2FhTWE0QkpxQ0I5TWdrN1VJVlJsNlZzdVF6VVU2cUorazFERVdDcGxr?=
 =?utf-8?B?YmYwWnRjZ0wzbTR4UVlCZDRJR3NZNHNOdFBWZnl2OGZEUGw1ckpoRWVGdFZL?=
 =?utf-8?B?L2JKc3lRNnZsM1JzOStpckQ1SkE5VGpSK1lMa1dTZFVudWRnSEpDbkNwTHRn?=
 =?utf-8?B?ZFNteStKK2ZLQjJ5ZmZjUnluSkVZR3piWXRYRzI2dXZMRk1Dd3doWEVXZTVa?=
 =?utf-8?B?WWlBMlNCVTg5ditncjRHMEJlQVI5a3NhdnQwN2tpek5yU2dzaXZ6TTllaHJj?=
 =?utf-8?B?WlNtMVRlR3crR1VPVUhOejJiekNMUXJ4L1VWK203cFZOME5VckI3TXB5TE5C?=
 =?utf-8?B?MEFCNis5Q3NKVGJqZEp6eWxld2JWYUJ2TzI0ektHUlpqSDZUSTNpOXZCS0VE?=
 =?utf-8?B?OHZFVG1OSlFjYU16L2pLNHl6SS9tZk9scUNSSGxEQzA3UDNFb09zZzEyYzVy?=
 =?utf-8?B?ZVVTYVg5UHFiVGVMVWFTbVRTVTdrUEk1VGdNQXI2M2h2U0JhcFdsRVZmZ0ZT?=
 =?utf-8?B?RklGdytGYVlxQk5MTGpTbk9EbExPNlpib2FZcDJOeGZqVXVOa052RDFaRGFy?=
 =?utf-8?B?NVA0b2JHOG50TDlKOFppcDZLdXVZVnJYbGI4czlaWnlON1NFV1d4aEpQK0FW?=
 =?utf-8?B?M2p0MTA4RmxRYjdnQmdoR3JlQTRHbnBOeXp1dkI5NW14KzlQUjFZNDlRcnhB?=
 =?utf-8?B?Nm11T2UxSWExdGpmMUFBV3EvMTJ0eFR1d1FPQW1sREQ0SnJhdk5HZHNHQmdP?=
 =?utf-8?B?Tm5jbVp3bkNLOThtMmt0Y1hFNW1VS0xmbUljUjAyRGtIbXAxRWRpbGhnN2dw?=
 =?utf-8?B?d01yZnVUZ3NiN1BENU5LWnB6RWVGNGdkSUt0ZUJ4ZHhkaGNaK0pCZm0xK1Nq?=
 =?utf-8?B?ZXUwdC8yRWlVK09xM2xDc3I5MUtLd01wMU5GYlhlZEtzanpqaVM0RllHZmRK?=
 =?utf-8?B?ZXlFdWZzek9pWG5UeGUvTmRqam5BeXlsUWNxTXg4dnE0R0FacytoUmpDc2R3?=
 =?utf-8?B?Zm9rMU1aU3k2QllqWVRzMVZPd3hJSjYzTDJIcTNUd0dNTTF3ZW1nK1cybGUx?=
 =?utf-8?B?dkZTcEJZR2RDME4xYlp6VXFZQnR6S0U5WTUvWTlUeDZjVDQzSWdCSC9sQkNG?=
 =?utf-8?B?SVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF0F86A482F0EB4DB8D5821B6678B2F8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f63a6f4-7888-4909-84d7-08dcd39fa5fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2024 02:56:21.7624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MrPjxfk3VsZYWMpmX0OflR5clNufH13MGV1vshZFpepg3TubyEyDtt+O2//CFDKK6KWOV7CXn//5sZl1o7RlrPsnCVF+YjyPtVZmrOZWpcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8281

SGkgQWxwZXIsDQoNCkkgdGhpbmsgdGhhdCdzIGEgcGxhdGZvcm0gaXNzdWUgYmVjYXVzZSBpdCB3
b3JrcyBmaW5kIGluIG15IE1UODE4OA0KcGxhdGZvcm0sIGJ1dCBJIGRvbid0IGhhdmUgYW55IE1U
ODE3MyBwbGF0Zm9ybS4NCg0KQ2FuIHlvdSBoZWxwIG1lIHRlc3QgdGhlIGZpeCBwYXRjaCBpbiB5
b3VyIE1UODE3MyBwbGF0Zm9ybT8NCkknbGwgcHJvdmlkZSBhIGZpeCBwYXRjaCBpbiAyIHdlZWtz
IHZpYSBHb29nbGUgQ2hhdC4NCg0KUmVnYXJkcywNCkphc29uLUpILkxpbg0KDQpPbiBGcmksIDIw
MjQtMDktMTMgYXQgMDE6MjUgKzAwMDAsIENLIEh1ICjog6Hkv4rlhYkpIHdyb3RlOg0KPiBIaSwg
SmFzb246DQo+IA0KPiBQbGVhc2UgaGVscCB0byBmaXggdGhpcyBpc3N1ZS4NCj4gT3RoZXJ3aXNl
LCBJIHdvdWxkIHJldmVydCB0aGlzIHNlcmllcy4NCj4gDQo+IFJlZ2FyZHMsDQo+IENLDQo+IA0K
PiBPbiBUaHUsIDIwMjQtMDktMTIgYXQgMjM6MjkgKzAzMDAsIEFscGVyIE5lYmkgWWFzYWsgd3Jv
dGU6DQo+ID4gIAkgDQo+ID4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxp
bmtzIG9yIG9wZW4gYXR0YWNobWVudHMNCj4gPiB1bnRpbCB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUg
c2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiA+ICBIaSwNCj4gPiANCj4gPiBPbiAyMDI0LTA3LTMx
IDE2OjM0ICswMzowMCwgQ2h1bi1LdWFuZyBIdSB3cm90ZToNCj4gPiA+IEhpLCBTaGF3bjoNCj4g
PiA+IA0KPiA+ID4gSHNpYW8gQ2hpZW4gU3VuZyB2aWEgQjQgUmVsYXkNCj4gPiA+IDxkZXZudWxs
K3NoYXduLnN1bmcubWVkaWF0ZWsuY29tQGtlcm5lbC5vcmc+IOaWvCAyMDI05bm0N+aciDE35pel
IOmAseS4iQ0KPiA+ID4g5LiL5Y2IMToyNOWvq+mBk++8mg0KPiA+ID4gPiANCj4gPiA+ID4gU3Vw
cG9ydCAiUHJlLW11bHRpcGxpZWQiIGFuZCAiTm9uZSIgYmxlbmQgbW9kZSBvbiBNZWRpYVRlaydz
DQo+ID4gPiA+IGNoaXBzIGJ5DQo+ID4gPiA+IGFkZGluZyBjb3JyZWN0IGJsZW5kIG1vZGUgcHJv
cGVydHkgd2hlbiB0aGUgcGxhbmVzIGluaXQuDQo+ID4gPiA+IEJlZm9yZSB0aGlzIHBhdGNoLCBv
bmx5IHRoZSAiQ292ZXJhZ2UiIG1vZGUgKGRlZmF1bHQpIGlzDQo+ID4gPiA+IHN1cHBvcnRlZC4N
Cj4gPiA+IA0KPiA+ID4gRm9yIHRoZSB3aG9sZSBzZXJpZXMsIGFwcGxpZWQgdG8gbWVkaWF0ZWst
ZHJtLW5leHQgWzFdLCB0aGFua3MuDQo+ID4gPiANCj4gPiA+IFsxXSANCj4gPiA+IGh0dHBzOi8v
Z2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2NodW5rdWFuZy5odS9saW51
eC5naXQvbG9nLz9oPW1lZGlhdGVrLWRybS1uZXh0DQo+ID4gDQo+ID4gSSBhbSBzZWVpbmcgYnJv
a2VuIGNvbG9ycyBvbiBhbiBNVDgxNzMgQ2hyb21lYm9vayB3aXRoIG5leHQtDQo+ID4gMjAyNDA5
MTIsDQo+ID4gd2hpY2ggZ29lcyBhd2F5IGlmIEkgZ2l0LXJldmVydCB0aGlzIHNlcmllcyAoY29t
bWl0cyAxZjY2ZmU2MmNjMDkNCj4gPiBlYjE3YzU5MDk0ODEgYTNmN2Y3ZWY0YmZlIDU5ZTlkOWRl
MjVmMCA0MjI1ZDVkNWU3NzkpLg0KPiA+IA0KPiA+IFRvIGlsbHVzdHJhdGUsIEkgdG9vayBhIHBp
Y3R1cmUgWzFdIG9mIHNvbWUgY29sb3IgbWl4aW5nIGRpYWdyYW1zDQo+ID4gZnJvbQ0KPiA+IFdp
a2lwZWRpYSBbMl0uIERvIHlvdSBoYXZlIGFuIGlkZWEgb2Ygd2hhdCBnb2VzIHdyb25nPw0KPiA+
IA0KPiA+IChJJ20gYnVzeSB3aXRoIHRvbyBtYW55IHRoaW5ncyBzbyBJIGRvbid0IHdhbnQgdG8g
ZGVidWcgaXQgbm93Li4uKQ0KPiA+IA0KPiA+IFsxXSBodHRwczovL2kuaW1ndXIuY29tL3RORnZv
dkIuanBlZw0KPiA+IFsyXSBodHRwczovL2VuLndpa2lwZWRpYS5vcmcvd2lraS9Db2xvcl9zcGFj
ZSNHZW5lcmljDQo+ID4gDQo=

