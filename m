Return-Path: <linux-kernel+bounces-230417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A93917C8A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1A001C22936
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774471684B9;
	Wed, 26 Jun 2024 09:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nREupeaM";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="nXz/XBqq"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361A28BEF
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 09:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719394357; cv=fail; b=SMEvjGFD78iy5hb3RYyBnvURZ09JNXTZY2rs6p2Xw2WaG3KYsQ7oV6xXE5JP+YRBF9eAHO307dQVtcxSobnDUvmVSPJ4SteB2LgfwHmsd+hkrksYhq7xMNBV4wjUy9WoYFFemeeJOE/iVtBWMXZeLqIL7jtx8AnD4FPRUmxDguQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719394357; c=relaxed/simple;
	bh=OSPQgnJGXjdGTRK0nzXzsSZOY9ecohxlYLnLMnhMFPk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a/NBX7VX9eduwFbJiUHqRe4fjc/eOG6tvD70uHCMIy6M1ErD39fqyJqkgqHR7uskKqlSi0L8s0WAXKeqmZQfi8VgGBTgi2LbuP7rvzYRREs9l7TAsFsrapX6nCajw7evh4KDSVkRHqaTQIV2ZXSZommjUtfJDGwZUt9OOF9R5aE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=nREupeaM; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=nXz/XBqq; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 005247b6339f11ef99dc3f8fac2c3230-20240626
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=OSPQgnJGXjdGTRK0nzXzsSZOY9ecohxlYLnLMnhMFPk=;
	b=nREupeaM2nK4OyoEgWtYhOI1Tu7Bjl5tMr+9I3lU2faQK7C9mUhvWiUO6pAeTleQqNXsGFJD43ko7aefGks5MyB2rJ6DK2Fb8Vu0NtdobfwP9godbyHBcJMsjwGBba4F7OeDJakSqKLMh8OPH4vEYmRL5497dJp7A35MvHlFwsw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:cd50522b-fc07-4d67-a537-13e8b881aedf,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:4a5b8e85-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 005247b6339f11ef99dc3f8fac2c3230-20240626
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 635523233; Wed, 26 Jun 2024 17:32:26 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 26 Jun 2024 17:32:25 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 26 Jun 2024 17:32:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=if0NjHzhLafOmGrHBR8gYkB7xnNpW5SA/7L2H3j49BxMiwHlmb6p/L71JS2fLgGqCcXauH9rA+jaoYxyYIfPxlSclhlZtc+yzkDc20ttyXr8ehTtoxaOaP12hPI2fYZgF/n3RLSx0/XHtTRLwj2en82TNpv9FRuOU759TOajVMzVaxluXE/9ffsO32V8WhHmMnHfYqQVmEUOxUI5wxOAGHmccIdX75GMiVADpDIlK+FoG95F8xXBo5NAkNCoEWxIy1XXoLRQ13Uehj6b5zasljlzw9sXj5SO7bXMPJiYNDInfEqbmpUS/azbvGkcug/itooaczF0DZo8FZdliUo+7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSPQgnJGXjdGTRK0nzXzsSZOY9ecohxlYLnLMnhMFPk=;
 b=YbvfpLMdZ+GG2uk2Fg9av/8i9TrzTHBmQntfM+mjj7tEHRmpq0Flxs08RYrHwLMTHLQ3xc6khbVy4ZZoykn8w+VAkIc7M5DJTUMHmP37TCHCVyxE16UY3UX00DQIef4ws4mOrEXfAQZpqlQyjxWqNzI8H2vnj4hvQb6EIZ2k31ltwEvABnp02V5ATdNJyGk5eq/1vl9b+3/E9dxwrrV1sJ0XWPd+QMyPUpbdWocvbMyk87WeXivzi3JtvhBdYX2NoviqIi5d2tmL/LkRbvPFTMiyBeEHu6UjkgHbH+kRWKdK8kgKhAgpJ/1cKTB7kNHkjasSeRP2Sh6qpU6on5rMkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSPQgnJGXjdGTRK0nzXzsSZOY9ecohxlYLnLMnhMFPk=;
 b=nXz/XBqqS/fd6V59Nnw+Qj0beAzuUIBlljN8lJUVf7pCS+LYJ4U3+oBm9oj1JE/jwVyopUbr96IcDjTPuqLK6KlRmVeu0DMecrMOfoIfIL3N5kCOCghmAt+YS59TJwb+DQmJFkNbrWIohbzDPUuVsePmGHDKN70uLpymB9htqtg=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYSPR03MB8518.apcprd03.prod.outlook.com (2603:1096:405:63::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 09:32:23 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 09:32:23 +0000
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
Thread-Index: AQHavg+NdbRKcT+3skGSUl4IqMicy7HMSVSAgADxdQCAAHoqAIABEY4AgAB6xoCAAPnzgIAAh/UAgAYULICAAGkzgIAApk4AgAALTYCAAek2AA==
Date: Wed, 26 Jun 2024 09:32:23 +0000
Message-ID: <d6f0e7072ec0e89e573e5720fb2b9c621eb9154c.camel@mediatek.com>
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
In-Reply-To: <CABb+yY1EZOsKUR7WUX0Ni0Ukbqz0+yRHswiu07tNXtY1A1gNUQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYSPR03MB8518:EE_
x-ms-office365-filtering-correlation-id: cea7a8aa-8c6f-491e-9dd7-08dc95c2e275
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|366014|376012|1800799022|38070700016;
x-microsoft-antispam-message-info: =?utf-8?B?dlVhN0dMRTJMc2d6YmhsYys3RlFqNUkwTzBlclA4b0o2NVZHSk1NY0RvbUhM?=
 =?utf-8?B?R0crd2ZZUW5CemJPTVNqR29RT1Y1UkdjdWJGTEtwYkh3TW1rSmlTay82K1RJ?=
 =?utf-8?B?Mi84K0JJTElLMWU0aDQ4dklNOTR2UUNiT1E1a042cDAyei9VeDZuS1ZYbG5U?=
 =?utf-8?B?M0JIck4rOXNpRGwwVFJDdUUwa2NLWmo0RE9xbVlpU0xsY0E5TmpuRHQzejZv?=
 =?utf-8?B?dXhMTzVCWGhYd0xUdk01QUF2c0hGSHExdXo0cWhtWVRKVmI2N3ZGRVllZEN4?=
 =?utf-8?B?Vm1mWVVIZDhzS2dBamhXUWlrL3pXTlp4L2NHWnpMYzUrc0I4VXJjaTJ3Zkg0?=
 =?utf-8?B?RTNXRkZIdXQvdWxZVFVxWnFEVktubFZhaXZOcDhqcVpaWXFFOGtaUGNVSm8w?=
 =?utf-8?B?L1ZJVk5ubkdCd0Fka25nVVZQM2Z4MVE2aTVyeHlKUmFjTHIwZG1CUncrbzlL?=
 =?utf-8?B?OHo1czF1RW9TTDV6YnJXMk5TM1ZPa1ROQlgyb1o1bytaQVlvY3U1blZqYUtw?=
 =?utf-8?B?RXNtYWxzZm4rSjJ2ZFRPc3pUYkxlWFlJVVd5U3EzdkVTVFMxd0UwVUt3dnV4?=
 =?utf-8?B?aGNjdUV1UzkwRDM4T25CaWNqcFF1TUFiWmZzcUZqdGxydDk5RHdCNmhlZWJy?=
 =?utf-8?B?aDlSR2Q3ZGl4Ui9hbXJKamlEeUlhekdGcEh0bHF0U3FZZC93bjZkS2lZcStJ?=
 =?utf-8?B?YTZDc2Nmc0JFUWZRblg4VXErRXJ0U0NNZm9jZVdtVjh2bkVIc0N3UFRsMXpx?=
 =?utf-8?B?U2N4S3ZCVjA4VHJJUFQ4czZNSFVJZTlvR0EweEtpY0tPWnVEaElrS3BJWmtH?=
 =?utf-8?B?ekVuZ20rdzR6S2pUdHVnNFRYbXpSRnBneWxCQTk0UWFvZ3JvdGtqUCtoTWdQ?=
 =?utf-8?B?MUJrSStMZzIrWDlWckdxeFd5REx1aEpJWjZUVVU3VXB0eFFZUnJlaEZQTDZS?=
 =?utf-8?B?Z3lPWEs0c2UvS3hValBQdmRmYzhTVEI1N2JkTFFEbExzZ0dTVk0yQ0plV0xF?=
 =?utf-8?B?clVCSHdSYVRXaEh3QXF2dW1EZjA2R01ZNWZDS2dHYlcwQWx0ekpyVkY3eHFX?=
 =?utf-8?B?aFI4QWxrNzZZRTJsaDdWUHZHWFE2NWUwN1hnZnY2YjNENFhPdEFnSGc4L3M2?=
 =?utf-8?B?MEc0MWp0bzFoZTgwSURiTHBCbFRsSjVBNXQ0bVVEbzBxbzgzT2QzaW83L01Q?=
 =?utf-8?B?SDNZQVhLSEZLSUZ1TUp3dGZwM1BUdndTU3JkbHhUK2pjb05tcVJrakdteHNy?=
 =?utf-8?B?TVAzUGxZbjVhUC96aUtDU1RYaFlLSXg0SkxXckdCbTlzcnAvaFZxV1BqRURO?=
 =?utf-8?B?S0svUHdmNk8xL1haRVlzMmdTcTBramJKalJ5QjJxTEFpWnkvQUNSd1BQVTBq?=
 =?utf-8?B?TTNOWldYeGV5d2Y4dkp2c2NFUmxMK2hQZ2pzcFBQMTg2SU42dHpkSHNvc3pL?=
 =?utf-8?B?SHoySnFvZm5Pejcrd0Ryd2I5WGZ0QjdWUnJZOFFTbjFXRGsxYmN3T213NWEx?=
 =?utf-8?B?MWV6U0xjZkNEZEEyWDJKOElybTl3N2p4bXBQOG94a2IzcUczakFTYTNvU2Nq?=
 =?utf-8?B?ZDRkRWIzL2JXTmxsNGRZRVJPcGJhV3Y5YWJsaEYraWo5Ny9XQzdUR1MrTW4y?=
 =?utf-8?B?T0JTVmxOTFB6alFyZHVKRnFGTzJPOTBRSmZOZ0JuZ1Y3QkJ1djF1czJ2Y0xW?=
 =?utf-8?B?REJ6TnFwUDBpekY4T3dIbC9QU0orV3g3Ukw4ZHAxQ2dubW1CbjZNUndBa3h0?=
 =?utf-8?B?QWI3MHdxVDM3bHRSdXc2b0phQUdOZTRBQXlxRm5SaUFiMUY2S2lVV3A1SzVG?=
 =?utf-8?B?dTMzc1hZMHR5S3R3VVlWRDZaK0JCZStHWjVCT2pKcUc5SEVqY1lHOTVpQS93?=
 =?utf-8?B?SXA4VDQxUC9qMzN1cHNaRTZvTGJRYzhBOXpRanYxMVBvbHc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tk5HTm5VbXgrbkZzem03a1EwREJ5ZmJIMEM4YU8xaWkxSlBrSXY0RlJmMlh3?=
 =?utf-8?B?ZUc2OXlGRVJJck1NVVBCY3lpc3Y1SzlnZGd4eWc5dVFjN0VGOWJwc25RZmdi?=
 =?utf-8?B?dG1xczczQ1NUR2NTQ3JvQ2hadHhJdTkveVA0a2pzUThTdkU2NDJDK0dGbUk3?=
 =?utf-8?B?dGRMc1dVZHpyTGFxWEV5UStKS2k3WlAzQTdjNnVkd2FPTm9Oc1NmcU9NNjE0?=
 =?utf-8?B?bHZrTCtyeE4vVE9iSGd2MXd4YlU0NGNUaVMxMHYxbUUvSERuWHNyUGpnMU5a?=
 =?utf-8?B?NW4zU2pEVUluOEVwSi80QUpNVlFab2k4Rldkd0tadHVhaFpubHlDUEdMWWgy?=
 =?utf-8?B?OFE3NVgzV2RaTXJETDdqd3dLVEZsb1ErQmlSSWpyVitrTzkybkN2U0lIV3R0?=
 =?utf-8?B?THc3c3B3VmJUSHV1Z09vSnMybjVSVmxZcDl3NDcweThqbmRSUUVCMUlIb1BG?=
 =?utf-8?B?ZlFpVzRHVjVyNTdSUndxTUJ1U1dZaWdabGhaZDJQem1Da3hGOEJRVTgzTVBF?=
 =?utf-8?B?R3JneW9pa3IydGxiaWdRNUZ2N3F4MEV3QkovZndMSDhWT3dDeXJCK2JyWlJs?=
 =?utf-8?B?L0hJdVNCc2NYenNZNWJBYXZ3Q3FWMVRDOU4vQnNLdlY3OWFjNTh4b1l5bERl?=
 =?utf-8?B?V244V04vSThwdUEvZllLNk5SSHRvUjB1dkJKN1ZsKzZaUHBHL00zTjdwU0lz?=
 =?utf-8?B?SDdPam9UOWw2RThobjBuenorVGl2ajBCZFdraGRuc1ZCK3k0NDBCY3J2NmMy?=
 =?utf-8?B?bFB3K3VwRUl5RyszRVhCSHdTb3gwTEJZOE9YS0lmNUV3dnlVamgwZXNUMXo3?=
 =?utf-8?B?YXpKS2lPVit0TzQ5SEZ0Y0RNcnFnd1YzU0lBQ0hyTEZTY2k3QjhJNHRzUXVx?=
 =?utf-8?B?QXRPakg3NWJXRXgrTU0zdXNKRGRmdEhZRDVrdzNKL0FXZFZoaUROSjk4VmlT?=
 =?utf-8?B?Rlg0TUYwazVZbHQvcTZLNjlmQkd0MWo1cG84L09BZE5NdFp5YVoyNEtjTDh0?=
 =?utf-8?B?RHZadXJ6T3FiT05SZ3BjK1lrUnllTkRSaXlHVVowVEJZZUpJU2dvM3lNeFdn?=
 =?utf-8?B?Qi9IY1h0YmtyTTRYKzJCaUI1Z3RpdldIS2hwakdOK0k5WXRXYXZCWFkwTUxB?=
 =?utf-8?B?ekYrQmdBR2U1U1lXVDJMMi9ta00zOGFzMmJHYVdSNEovUTM1VEpaODdwYUNH?=
 =?utf-8?B?Zitub0FTWC9ScVg0TkZpeHBFZ0padWNBakJOdytHUjhzVklnaWZUblFEWFVm?=
 =?utf-8?B?UFdnQll1T0lVeGJ1VVhBV1dMWWh1UTFwYmphYlJxVWRtOEdSWlhBUStrZmxh?=
 =?utf-8?B?Rk5rRzRXemw4blFaWWQvVnE0SlpFSkRGK1RNQUJBQ2RTSFlSRVhBc01sNHA5?=
 =?utf-8?B?QS9DWGFYV1FNNjR6SGNzYnZ0TWF1d2NIaXpKeVV2Kys3Nm9wdEhwRlZSaVdL?=
 =?utf-8?B?NGRPN2RvbHZBS3NpdXVVTnlnRGFhak00bHFpMysyV2pPUXF1V2pkRWYvS1Bh?=
 =?utf-8?B?aWFSVE9lcUFjbHVRYUtCMkRudnBhaXozN1VobHZZb295bVV0d0xqaHJWb1Zw?=
 =?utf-8?B?OURnK3NQeDZSVmthMlk1R2JkVzR2Q29tb0ZYUlB0KzJtdGE3YzA4dDB2a0gr?=
 =?utf-8?B?YVJ3engvc3R3elY1MTdTRE9aUE9MRTh5cUFURHlQVkl0YmlBKysxMFJHd0U3?=
 =?utf-8?B?UFZVcDd3TWdYWWV0cFlSZm1QazhPYStidm51cnVmWGJjR0JwMXVkM3ZnRW5K?=
 =?utf-8?B?Q2lJODJQc0NLS2E0eGRPUENKTWZrR1Mxd3NDck50NmtNSWVpUTlML1ZmaGxx?=
 =?utf-8?B?YngzL1Z2NlB4V1M4TVQveStFWGt4RnJVcEZQMTloV3NjRE9XdWs4emRmNXhT?=
 =?utf-8?B?OVM3d1RqazZBbHNEbWI2dnBBOFVtYXJpT1pTdkdkNy9RMmdSb2lZN1hRT3FY?=
 =?utf-8?B?TUxiNm85MXpiOXMrcWk4Qzhnc0QwOTdPYndVaE1qcFZtcVRLa3l6QmlqckRl?=
 =?utf-8?B?NnJiSFo3bFM3aEloRFpwSjFoV2VZQUtCWFJISENkRHlZUkJ2MGlLd1ZwSGVE?=
 =?utf-8?B?YksrWHNYbjloNnNaT04xQkFialFxVXpBRkNtNnorRVVSZHRFN3Uxb2xOZ1Zo?=
 =?utf-8?B?MHprTFo2akwyQWI2WFhkVldzamdod1hKM0dhL2QrMU5CU3J1aS90TTJ3dnY1?=
 =?utf-8?B?b0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9188B4C95CC7BE489F47CD60FE63F98A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cea7a8aa-8c6f-491e-9dd7-08dc95c2e275
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 09:32:23.4917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zoTmj+jhQNQYO1H2y5zx+dw4uAMJN7S5aEeADx9A710tE13eI3b0j8szO/4RcSXIFG6/5dwiiKb/iRuqSaQek6cRy+421CKki/vqBbsL81w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8518

DQpbc25pcF0NCg0KPiA+ID4gPiAiSSB3YW50IG51bWJlcnMiIGlzIGEgc2Vuc2libGUgcmVxdWVz
dCwgaG9uZXN0bHkgSSB3b3VsZCBkbyB0aGUNCj4gPiA+IHNhbWUgc28gSSB0b3RhbGx5DQo+ID4g
PiA+IHVuZGVyc3RhbmQgdGhhdC4NCj4gPiA+ID4NCj4gPiA+ID4gSmFzb24sIGNhbiB5b3UgcGxl
YXNlIHBlcmZvcm0gbGF0ZW5jeSBtZWFzdXJlbWVudHMgb24gNjBIeiBhbmQNCj4gPiA+ICplc3Bl
Y2lhbGx5KiBJU1AvY2FtDQo+ID4gPiA+IGNhc2VzIHdoaWxlICJjb250aW51b3VzbHkiIGNhbGxp
bmcgc3RhcnR1cCgpIGFuZCBzaHV0ZG93bigpIGZvcg0KPiA+ID4gZXZlcnkgcG93ZXIgc2F2aW5n
DQo+ID4gPiA+IG9wZXJhdGlvbj8NCj4gPg0KPiA+IFlvdSBtZWFuIG1vdmluZyBjbGtfYnVpbGtf
ZW5hYmxlKCkgYW5kIGNsa19idWxrX2Rpc2FibGUoKSB0bw0KPiBzdGFydHVwKCkNCj4gPiBhbmQg
c2h1dGRvd24oKSwgYW5kIHRoZW4gY2FsbGluZyBzdGFydHVwKCkgaW4gY21kcV9ydW50aW1lX3Jl
c3VtZSgpDQo+IGFuZA0KPiA+IGNhbGxpbmcgc2h1dGRvd24oKSBpbiBjbWRxX3J1bnRpbWVfc3Vz
cGVuZCgpPw0KPiA+IElmIHdlIGRvIHRoYXQsIEkgdGhpbmsgR0NFIGNsb2NrcyB3aWxsIG5ldmVy
IGJlIGNsb3NlZCBiZWNhdXNlDQo+ID4gbWJveF9yZXF1ZXN0X2NoYW5uZWwoKSBhbmQgbWJveF9m
cmVlX2NoYW5uZWwoKSB3aWxsIGNhbGwgc3RhcnR1cCgpDQo+IGFuZA0KPiA+IHNodXRkb3duKCkg
YWxyZWFkeS4NCj4gPg0KPiA+IEkgZm91bmQgdGhhdCBkaXNwbGF5IHRocmVhZDowIHdpbGwgY2Fs
bCBtYm94X3NlbmRfbWVzc2FnZSgpIGV2ZXJ5DQo+IDE2bXMNCj4gPiB3aGVuIEkgbW92aW5nIFVJ
IGNvbnRpbnVvdXNseToNCj4gPiBbICAgNjEuNTAzNjA0XSB0aHJlYWRfaWQ6MCwgc2VuZF9kaWZm
OjE2IG1zDQo+ID4gWyAgIDYxLjUyMDI2Nl0gdGhyZWFkX2lkOjAsIHNlbmRfZGlmZjoxNiBtcw0K
PiA+IFsgICA2MS41MzcxNDNdIHRocmVhZF9pZDowLCBzZW5kX2RpZmY6MTYgbXMNCj4gPiBbICAg
NjEuNTUzNjA5XSB0aHJlYWRfaWQ6MCwgc2VuZF9kaWZmOjE2IG1zDQo+ID4gWyAgIDYxLjU3MDgx
MV0gdGhyZWFkX2lkOjAsIHNlbmRfZGlmZjoxNyBtcw0KPiA+IFsgICA2MS41ODcwNzVdIHRocmVh
ZF9pZDowLCBzZW5kX2RpZmY6MTYgbXMNCj4gPiBbICAgNjEuNjAzNTI3XSB0aHJlYWRfaWQ6MCwg
c2VuZF9kaWZmOjE2IG1zDQo+ID4gWyAgIDYxLjYyMDA4Ml0gdGhyZWFkX2lkOjAsIHNlbmRfZGlm
ZjoxNiBtcw0KPiA+IFsgICA2MS42Mzc0OTZdIHRocmVhZF9pZDowLCBzZW5kX2RpZmY6MTcgbXMN
Cj4gPiBbICAgNjEuNjUzODc2XSB0aHJlYWRfaWQ6MCwgc2VuZF9kaWZmOjE2IG1zDQo+ID4gWyAg
IDYxLjY3MDE2Ml0gdGhyZWFkX2lkOjAsIHNlbmRfZGlmZjoxNiBtcw0KPiA+IFsgICA2MS42ODcz
MThdIHRocmVhZF9pZDowLCBzZW5kX2RpZmY6MTcgbXMNCj4gPiBbICAgNjEuNzAzNzQ3XSB0aHJl
YWRfaWQ6MCwgc2VuZF9kaWZmOjE2IG1zDQo+ID4gWyAgIDYxLjcyMDY1Nl0gdGhyZWFkX2lkOjAs
IHNlbmRfZGlmZjoxNiBtcw0KPiA+IElmIEkgZGlkbid0IGRvIGFueXRoaW5nIHRvIFVJLCBJIHdv
bid0IHNlZSBhbnkgbWJveF9zZW5kX21lc3NhZ2UoKQ0KPiA+IGxvZ3MuDQo+ID4NCj4gPiBJdCBt
ZWFucyBtYm94X3NlbmRfbWVzc2FnZSgpIHdpbGwgb25seSBiZSBjYWxsZWQgd2hlbiB0aGUgZGlz
cGxheQ0KPiBpcw0KPiA+IHVwZGF0ZWQ6DQo+ID4gWyAgNzgyLjc3NzIwNV0gdGhyZWFkX2lkOjAs
IHNlbmRfZGlmZjoyMDA3MiBtcw0KPiA+IFsgIDgyMC4yOTY3MzhdIHRocmVhZF9pZDowLCBzZW5k
X2RpZmY6Mzc1MTkgbXMNCj4gPiBbICA4NjMuMDM0MjcwXSB0aHJlYWRfaWQ6MCwgc2VuZF9kaWZm
OjQyNzM3IG1zDQo+ID4gWyAgODgwLjI5Nzc1OV0gdGhyZWFkX2lkOjAsIHNlbmRfZGlmZjoxNzI2
MyBtcw0KPiA+IFsgIDkxNy43OTU0MzJdIHRocmVhZF9pZDowLCBzZW5kX2RpZmY6Mzc0OTcgbXMN
Cj4gPg0KPiA+DQo+ID4gV2hlbiBvcGVuaW5nIGNhbWVyYSBBUFAsIGl0IHNlZW1zIHRvIGJlY29t
ZSAzMGZwczoNCj4gPiBbICAxMjAuNTUxNzc4XSBCVUc6IHNsZWVwaW5nIGZ1bmN0aW9uIGNhbGxl
ZCBmcm9tIGludmFsaWQgY29udGV4dA0KPiBhdA0KPiA+IGRyaXZlcnMvYmFzZS9wb3dlci9ydW50
aW1lLmM6MTE2NA0KPiA+IFsgIDEyMC41NjA4NDRdIGluX2F0b21pYygpOiAxLCBpcnFzX2Rpc2Fi
bGVkKCk6IDEyOCwgbm9uX2Jsb2NrOiAwLA0KPiBwaWQ6DQo+ID4gMjAxLCBuYW1lOiBrd29ya2Vy
L3UxNzoxDQo+ID4gWyAgMTIwLjU2OTM2M10gcHJlZW1wdF9jb3VudDogMSwgZXhwZWN0ZWQ6IDAN
Cj4gPiBbICAxMjAuNTczMzY3XSBSQ1UgbmVzdCBkZXB0aDogMCwgZXhwZWN0ZWQ6IDANCj4gPiBb
ICAxMjAuNTc3NDU3XSBJTkZPOiBsb2NrZGVwIGlzIHR1cm5lZCBvZmYuDQo+ID4gWyAgMTIwLjU4
MTM3Ml0gaXJxIGV2ZW50IHN0YW1wOiAwDQo+ID4gWyAgMTIwLjU4NDQyMF0gaGFyZGlycXMgbGFz
dCAgZW5hYmxlZCBhdCAoMCk6IFs8MDAwMDAwMDAwMDAwMDAwMD5dDQo+IDB4MA0KPiA+IFsgIDEy
MC41OTA2ODddIGhhcmRpcnFzIGxhc3QgZGlzYWJsZWQgYXQgKDApOiBbPGZmZmZmZmQzNjI0YTg2
ZTA+XQ0KPiA+IGNvcHlfcHJvY2VzcysweDU3OC8weGYxMA0KPiA+IFsgIDEyMC41OTg3ODBdIHNv
ZnRpcnFzIGxhc3QgIGVuYWJsZWQgYXQgKDApOiBbPGZmZmZmZmQzNjI0YTg2ZWM+XQ0KPiA+IGNv
cHlfcHJvY2VzcysweDU4NC8weGYxMA0KPiA+IFsgIDEyMC42MDY4NjVdIHNvZnRpcnFzIGxhc3Qg
ZGlzYWJsZWQgYXQgKDApOiBbPDAwMDAwMDAwMDAwMDAwMDA+XQ0KPiAweDANCj4gPiBbICAxMjAu
NjEzMTI4XSBDUFU6IDAgUElEOiAyMDEgQ29tbToga3dvcmtlci91MTc6MSBOb3QgdGFpbnRlZA0K
PiA2LjEuOTItDQo+ID4gbG9ja2RlcC0xNDQxOS1nOGM1ZjIwZTU2NTk4LWRpcnR5ICMxDQo+ID4g
ZTk3MTExMmU4M2U3OTYyMzlhNDFlNDZlODc0Nzc5NGM3MzdmYjE4Yw0KPiA+IFsgIDEyMC42MjYw
NzNdIEhhcmR3YXJlIG5hbWU6IEdvb2dsZSBDaXJpIHNrdTAvdW5wcm92aXNpb25lZCBib2FyZA0K
PiAoRFQpDQo+ID4gWyAgMTIwLjYzMjQyMF0gV29ya3F1ZXVlOiBpbWdzeXNfcnVubmVyIGltZ3N5
c19ydW5uZXJfZnVuYw0KPiA+IFsgIDEyMC42Mzc2NDddIENhbGwgdHJhY2U6DQo+ID4gWyAgMTIw
LjY0MDA4Nl0gIGR1bXBfYmFja3RyYWNlKzB4MTAwLzB4MTIwDQo+ID4gWyAgMTIwLjY0MzkxOV0g
IHNob3dfc3RhY2srMHgyMC8weDJjDQo+ID4gWyAgMTIwLjY0NzIzMF0gIGR1bXBfc3RhY2tfbHZs
KzB4ODQvMHhiNA0KPiA+IFsgIDEyMC42NTA4OTFdICBkdW1wX3N0YWNrKzB4MTgvMHg0NA0KPiA+
IFsgIDEyMC42NTQyMDNdICBfX21pZ2h0X3Jlc2NoZWQrMHgyMDQvMHgyMTQNCj4gPiBbICAxMjAu
NjU4MTIzXSAgX19taWdodF9zbGVlcCsweDUwLzB4ODANCj4gPiBbICAxMjAuNjYxNjkyXSAgX19w
bV9ydW50aW1lX3Jlc3VtZSsweDQ4LzB4YmMNCj4gPiBbICAxMjAuNjY1Nzg2XSAgY21kcV9tYm94
X3NlbmRfZGF0YSsweDhjLzB4NDM0DQo+ID4gWyAgMTIwLjY2OTk2Nl0gIG1zZ19zdWJtaXQrMHg4
NC8weDEwNA0KPiA+IFsgIDEyMC42NzMzNjJdICBtYm94X3NlbmRfbWVzc2FnZSsweGI4LzB4MTI0
DQo+ID4gWyAgMTIwLjY3NzM2NV0gIGltZ3N5c19jbWRxX3NlbmR0YXNrKzB4Njg4LzB4OTI4DQo+
ID4gWyAgMTIwLjY4MTcxN10gIGltZ3N5c19ydW5uZXJfZnVuYysweDQ0LzB4NzgNCj4gPiBbICAx
MjAuNjg1NzIyXSAgcHJvY2Vzc19vbmVfd29yaysweDI3NC8weDU3NA0KPiA+IFsgIDEyMC42ODk3
MzFdICB3b3JrZXJfdGhyZWFkKzB4MjQwLzB4M2YwDQo+ID4gWyAgMTIwLjY5MzQ3NV0gIGt0aHJl
YWQrMHhmYy8weDExYw0KPiA+IFsgIDEyMC42OTY2MTJdICByZXRfZnJvbV9mb3JrKzB4MTAvMHgy
MA0KPiA+IFsgIDEyMC43MTA1NzBdIG10ay1jYW0gcmF3IDE2MDMwMDAwLmNhbS1yYXctYTogW1NP
Rl0gZnJhbWUgZG9uZQ0KPiByZWFkaW5nDQo+ID4gbG9zdCBmcmFtZXMuIHJlcSg3KSx0cygxMjA2
OTc3ODAwODMpDQo+ID4gWyAgMTIwLjcyMDM1Ml0gbXRrLWNhbSByYXcgMTYwMzAwMDAuY2FtLXJh
dy1hOiBbU09GXSBTQ1FfREVMQVkNCj4gc3RhdGU6NA0KPiA+IHRzOjEyMDY5Nzc4MDA4Mw0KPiA+
IFsgIDEyMC45OTAwOTFdIHRocmVhZF9pZDowLCBzZW5kX2RpZmY6MTQ3MCBtcw0KPiA+IFsgIDEy
MS4wMDcyMTBdIHRocmVhZF9pZDowLCBzZW5kX2RpZmY6MTcgbXMNCj4gPiBbICAxMjEuMDE2NDg0
XSB0aHJlYWRfaWQ6MCwgc2VuZF9kaWZmOjkgbXMNCj4gPiBbICAxMjEuMDMyNjUyXSB0aHJlYWRf
aWQ6MCwgc2VuZF9kaWZmOjE2IG1zDQo+ID4gWyAgMTIxLjA0OTM2Nl0gdGhyZWFkX2lkOjAsIHNl
bmRfZGlmZjoxNiBtcw0KPiA+IFsgIDEyMS4wNjY4ODBdIHRocmVhZF9pZDowLCBzZW5kX2RpZmY6
MTcgbXMNCj4gPiBbICAxMjEuMDg3MDIzXSB0aHJlYWRfaWQ6MCwgc2VuZF9kaWZmOjIwIG1zDQo+
ID4gWyAgMTIxLjA5OTMyNV0gdGhyZWFkX2lkOjAsIHNlbmRfZGlmZjoxMiBtcw0KPiA+IFsgIDEy
MS4xMzUyODZdIHRocmVhZF9pZDowLCBzZW5kX2RpZmY6MzUgbXMNCj4gPiBbICAxMjEuMTQ5MzQ5
XSB0aHJlYWRfaWQ6MCwgc2VuZF9kaWZmOjE0IG1zDQo+ID4gWyAgMTIxLjE3OTI1OV0gdGhyZWFk
X2lkOjAsIHNlbmRfZGlmZjoyOSBtcw0KPiA+IFsgIDEyMS4yMDMxODNdIHRocmVhZF9pZDowLCBz
ZW5kX2RpZmY6MjMgbXMNCj4gPiBbICAxMjEuMjQyMjM0XSB0aHJlYWRfaWQ6MCwgc2VuZF9kaWZm
OjM5IG1zDQo+ID4gWyAgMTIxLjI4MDY0NV0gdGhyZWFkX2lkOjAsIHNlbmRfZGlmZjozOCBtcw0K
PiA+IFsgIDEyMS4zMTg2NTFdIHRocmVhZF9pZDowLCBzZW5kX2RpZmY6MzggbXMNCj4gPiBbICAx
MjEuMzU2MzY2XSB0aHJlYWRfaWQ6MCwgc2VuZF9kaWZmOjM3IG1zDQo+ID4gWyAgMTIxLjM5NDQ4
NF0gdGhyZWFkX2lkOjAsIHNlbmRfZGlmZjozOCBtcw0KPiA+DQo+ID4gVGhlIGNtZHFfcnVudGlt
ZV9zdXNwZW5kKCkgd2lsbCBvbmx5IGJlIGNhbGxlZCB3aGVuIEkgZGlzYWJsZWQNCj4gY2FtZXJh
DQo+ID4gQVBQOg0KPiA+IFsgIDQ2OC4xMzc1MzBdIHBtX29uIHRzOjQ2NTI1OSwgcG1fb2ZmIHRz
OjQ2ODEzNzUsIGRpZmY6Mjg3NyBtcw0KPiA+IGFuZCB0aGUgZGlmZiBpcyB0aGUgZHVyYXRpb24g
ZnJvbSBvcGVuaW5nIHRoZSBjYW1lcmEgQVBQIHRvIGNsb3NpbmcNCj4gdGhlDQo+ID4gY2FtZXJh
IEFQUC4NCj4gPg0KPiA+IEZyb20gYm9vdGluZyB0byBzZWVpbmcgdGhlIFVJIGFuZCBhbnkgb3Bl
cmF0aW9uIG9mIFVJLCBJIGRpZG4ndCBzZWUNCj4gPiBhbnkgY21kcV9ydW50aW1lX3N1c3BlbmQo
KSBsb2dzIGZyb20gZGlzcGxheSBtYm94IGNoYW5uZWwuDQo+ID4gU28gY21kcV9ydW50aW1lX3Jl
c3VtZSgpIGFuZCBjbWRxX3J1bnRpbWVfc3VzcGVuZCgpIGFyZSBuZXZlcg0KPiBjYWxsZWQgYnkN
Cj4gPiBkaXNwbGF5IG1ib3ggY2hhbm5lbC4NCj4gPiBUaGlzIGNhbiB0ZWxsIHdoeSBvbmx5IG9w
ZW5pbmcgdGhlIGNhbWVyYSBBUFAgY2FuIHNlZSB0aGlzIEJVRw0KPiByZXBvcnQuDQo+ID4NCj4g
PiA+ID4NCj4gPiA+IFRvIGJlIGNsZWFyLCBkbyB3aXRoIHRoZSBtYWlsYm94IGNoYW5uZWwgdGhh
dCB5b3UgZG8gd2l0aCB0aGUNCj4gY2xvY2tzDQo+ID4gPiBub3csIGJlY2F1c2UgeW91ciBzdGFy
dHVwKCkgaXMgbGl0ZXJhbGx5IGFuZCBzaHV0ZG93bigpIGlzDQo+ID4gPiBwcmFjdGljYWxseQ0K
PiA+ID4gZW1wdHkuDQo+ID4gPiBDYWxsIHNodXRkb3duKCkgd2hlbiBubyByZXF1ZXN0IGhhcyBj
b21lIGluIGZvciBhIHdoaWxlLCBzbyB5b3UNCj4ga25vdw0KPiA+ID4gdGhlIGNsaWVudCBoYXMg
cXVpZXNjZWQgbGlrZWx5LiBTbyB0cnkgcHV0dGluZyByZXF1ZXN0L3JlbGVhc2UgaW4NCj4gPiA+
IGhpZ2hlciBsZXZlbCBSUE0gd2l0aCBhdXRvc3VzcGVuZC4NCj4gPg0KPiA+IEknbSBub3QgcXVp
dCBzdXJlIGhvdyB0byBtb2RpZnkgdGhpcyBmcm9tIGN1cnJlbnQgdXNhZ2UuDQo+ID4gRG8geW91
IG1lYW46DQo+ID4gMS4gTW92ZSBwbV9ydW50aW1lX2dldF9zeW5jKCkgZnJvbSBjbWRxX21ib3hf
c2VtZF9kYXRhKCkgdG8NCj4gc3RhcnR1cCgpDQo+ID4gYW5kIGtlZXAgcG1fcnVudGltZV9wdXRf
YXV0b3N1c3BlbmQoKSBpbiBjbWRxX21ib3hfc2VtZF9kYXRhKCk/DQo+ID4NCj4gPiAyLiBDYWxs
IHNodXRkb3duKCkgaW4gY21kcV9ydW50aW1lX3N1c3BlbmQoKT8NCj4gPg0KPiBObyBzaHV0ZG93
bigpIGlzIGNhbGxlZCBmcm9tIGNoYW5uZWwgcmVsZWFzZS4gTWF5YmUgcmVsZWFzZSB0aGUNCj4g
Y2hhbm5lbCBmcm9tIHN1c3BlbmQoKSBvZiB1c2VyIGRyaXZlciAoaW1nc3lzKS4NCg0KV2hlbiB1
c2VycyBjYWxsIG1ib3hfY2hhbm5lbF9yZXF1ZXN0KCksIHRoZXJlIGlzIG5vdGhpbmcgdG8gZG8g
d2l0aCBIVywNCnNvIENNRFEgZHJpdmVyIGxlYXZlcyBzdGFydHVwKCkgZW1wdHkuDQpXaGVuIHVz
ZXJzIGNhbGwgbWJveF9zbmVkX21lc3NhZ2UoKSwgdXNlcnMgd2FudCB0byB1c2UgSFcgdG8gZXhl
Y3V0ZQ0Kc29tZSBpbnN0cnVjdGlvbiwgc28gQ01EUSBkcml2ZXIgbmVlZHMgdG8gZW5hYmxlIHRo
ZSBwb3dlci9jbG9ja3MgaW4NCnRoaXMgZnVuY3Rpb24uDQpXaGVuIHVzZXJzIGNhbGwgbWJveF9m
cmVlX2NoYW5uZWwoKSBvciBtYm94X2ZsdXNoKCksIENNRFEgZHJpdmVyIG5lZWRzDQp0byBjaGVj
ayB0aGUgSFcgZXhlY3V0aW5nIHN0YXR1cyBhbmQgY2xlYXJzIGFsbCB0aGUgZXhlY3V0aW5nIHRh
c2tzLCBzbw0KaXQgYWxzbyBuZWVkcyB0byBlbmFibGUgcG93ZXIvY2xvY2tzIGluIHNodXRkb3du
KCkgYW5kIGZsdXNoKCkgdG8NCmNvbnRyb2wgdGhlIEhXLg0KDQpUaGUgcG93ZXIgc2F2aW5nIGdv
YWwgaXMgdG8gZGlzYWJsZSB0aGUgcG93ZXIvY2xrIG1vcmUgdGhhbiB0aGUNCmNvbmZpZ3VyYWJs
ZSB0aW1lb3V0ICgxMDBtcyBjdXJyZW50bHkpIGFmdGVyIGVuYWJsaW5nIGl0Lg0KU28gSSB0aGlu
ayBjYWxsaW5nIHN1c3BlbmQoKSBvZiB1c2VyIGRyaXZlciBjYW4gbm90IGFjaGlldmUgdGhpcy4N
ClBsZWFzZSBjb3JyZWN0IG1lIGlmIEknbSB3cm9uZyA6KQ0KDQo+IA0KPiBUaGUgaWRlYSBpcyB0
aGF0DQo+IDEpIElmIHRoZSBnYXAgYmV0d2VlbiB0cmFuc2ZlcnMgb24gYSBidXN5IGNoYW5uZWwg
aXMgfjEwbXMgb3INCj4gbW9yZS4gIEFuZCAuLg0KPiAyKSBUaGUgc2lsZW5jZSBvbiB0aGUgbWFp
bGJveCBjaGFubmVsIGlzIG11bHRpcGxlIG9mIDEwMG1zLiBBbmQgLi4uDQoNClRoZSBtYWlsYm94
IGNoYW5uZWwgd291bGQgbm90IGJlIGFsd2F5cyBidXN5IGFuZCB0aGUgZ2FwIGlzIG5vdA0KY29u
c2lzdGVudCBhcyB3ZWxsLg0KRm9yIGV4YW1wbGUsIGRpc3BsYXkgZHJpdmVyIGNhbGxzIG1ib3hf
c2VuZF9tZXNzYWdlKCkgZXZlcnkgfjE2bXMgd2hpbGUNClVJIGlzIHVwZGF0aW5nIGluIDYwZnBz
Lg0KSWYgVUkgZG9zZSBub3QgdXBkYXRlLCBkaXNwbGF5IGRyaXZlciB3b24ndCBjYWxsIG1ib3hf
c2VuZF9tZXNzYWdlKCksDQpzbyB1c2VyIG1heSBub3QgaGFzIHRoZSBnYXAgYW5kIHRoZSBzaWxl
bmNlIGxpa2UgdGhpcy4NCg0KPiAzKSBzdGFydHVwKCkgYW5kIHNodXRkb3duKCkgYXJlIGVtcHR5
IChhcyBpbiB5b3VyIGRyaXZlcikNCj4gICAuLi4gdGhlbiB5b3UgY291bGQgYWZmb3JkIHRvIHJl
bGVhc2Uvc3VzcGVuZCBhbmQgcmVzdW1lL3JlcXVlc3QNCj4gZHVyaW5nIHRoZSBzaWxlbmNlIHBl
cmlvZCBiZWNhdXNlIHRoZSBfYXBpXyBjb3N0IG9mIHJlcXVlc3QvcmVsZWFzZQ0KPiBzaG91bGQg
bm90IGV2ZW4gYmUgMW1zLiBZb3VyIHN0YWNrIG1heSBiZSBkZXNpZ25lZCB0byBtYWtlIGRvaW5n
IHRoYXQNCj4gZGlmZmljdWx0IGJ1dCBudW1iZXJzIHdpc2UgaXQgc2hvdWxkIHdvcmsuDQoNClll
cywgdGhhdCdzIHRydWUsIGJ1dCBJIHRoaW5rIHdlIGNhbiBub3QgYWNoaWV2ZSB0aGUgZ29hbCBk
dXJpbmcgdGhlDQpzdXNwZW5kL3Jlc3VtZSBzdGFnZS4NCg0KQ3VycmVudGx5LCB3ZSB1c2UgdGhl
IHBtX3J1bnRpbWVfZ2V0X3N5bmMoKSBhbmQNCnBtX3J1bnRpbWVfYXV0b19zdXNwZW5kKCkgdG8g
YWNoaWV2ZSB0aGlzLg0KU28gSSB0aGluayBhZGRpbmcgdGhlIFBNIGZ1bmN0aW9uIGhvb2sgaW4g
bWFpbGJveCBkcml2ZXIgaXMgbXVjaCBiZXR0ZXINCmZvciB1c2VycyBkcml2ZXIgYW5kIGFsc28g
bW9yZSBmbGV4aWJsZSBmb3IgdGhlIGNvbnRyb2xsZXIgZHJpdmVyLg0KDQpQbGVhc2UgY29ycmVj
dCBtZSBpZiB0aGVyZSBpcyBzb21ldGhpbmcgSSBtaXN1bmRlcnN0b29kIDopDQoNClJlZ2FyZHMs
DQpKYXNvbi1KSC5MaW4NCg0KPiANCj4gVGhhbmtzDQo=

