Return-Path: <linux-kernel+bounces-214237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE839081AE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 04:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07B8E1F2203F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 02:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB81B1822D6;
	Fri, 14 Jun 2024 02:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OUdflOLs";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="udPjBgZJ"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F16183095
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 02:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718332366; cv=fail; b=a+ce1lB4e7EvgmC2+UpPaP4/W7Nn19Fo2Ke6jRyVxFkh7ck2jlVMCEGTxWnmnYLNKl+8lP+xuOojmU7FfYLpB0EZazB9akHhyozr/xGqgvmzqAPnkoyRiCC8kR2rq8m9o5lLyR1bwbtpZYS27GmWvwdv7AAWj5VZ+GUjmbQ39AE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718332366; c=relaxed/simple;
	bh=MlFgMsKFzomBWmZgErSu+/LNgHMawQ73+FhZrmUm5mI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=evKmpR4ZKhDDISWsBIOTQ0KyKQqYa5gjj63T+UhlElo3fP+Wal4SapUrJAwJckmfxIkco5pWffIDrQsGHmZj9pOe1Wu0x2zGwCXWWWZ8BR/q/J4a3ZMe+zche+xEYeDXnkTPm7qetboDb4z9piN7Fb2vsde1ftUAQ3+V5Q/tsCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=OUdflOLs; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=udPjBgZJ; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 58e43ebe29f611efa22eafcdcd04c131-20240614
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=MlFgMsKFzomBWmZgErSu+/LNgHMawQ73+FhZrmUm5mI=;
	b=OUdflOLsliBpevO2paWTlY2a3fBFONwIrxxtjRfWuTt4Iwq62e76cWSnpVjrWNk+aXNAdD81d/yWs3AzAaGxBD59EkklF9OTDCf1E0GWthvxh0FVgWwykSGWHJ5vh7ION0nLR6NWskk3rapbw8WAOIDOiWu05Q6NGxPDb33LurU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:5318d901-9304-4e48-9120-0d7a6592a9b2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:2ed01185-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 58e43ebe29f611efa22eafcdcd04c131-20240614
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <jia-hao.bai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1021093782; Fri, 14 Jun 2024 10:32:30 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 14 Jun 2024 10:32:28 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 14 Jun 2024 10:32:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpxFExytM1aW45X7AD++IE1c05FUQsauVfs/G2XFUdDZEYwZLktVg7sI58lYHdZv/65edpo2OTVKechkD06nH5Glw15NFC0RPmNG3iaw39g1AqAVxie8H8bG8X3g7CHyoJw55kxT4OEgviYJjpsgp4mCV5pfTmtdVlfBMN4MVTptVeekIGAodz/oMSIuTAu6Ixw4YWZR/RUfc55dpEQ3fgTYKhLzvEXfz6K2gyzTlw1ZyfNa2MHcHMBfsjBjbowsTVfcXkdQWfgAo6DcHLDRUNVo41Zz5sLUWWoZcVogWBtXZ7LvqJ1A9/wIYaPTIA2DgNC1ojXwrv4FoZMZSSM0Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MlFgMsKFzomBWmZgErSu+/LNgHMawQ73+FhZrmUm5mI=;
 b=SaO/gS+I5yOduG8ptKjKc7t0A78izVUjQSlNpRNQn5ltIJENLu4MwAhqrgk+UQM/o0IORVF0JQ8cKw67cqTfvhECMdCTMnV51b25mpM81fzdAH54MILEuPuthSoX4iPs/x6XLIOwOb/19dXS6jtUvXrubXRfYS64FoT0rO5IXRtuVNiu+GvyymkX1n1x3CMulqlsPy+cFxjh1C42dZevsl3uZrpLLXmGxAKPVpmeMluE63C31mRDT8QHNX/74HVn66PP/RJdYpzRlu+u90dR/9dalr4wM+cl+kofFxH3pVR1OHSobjmUlOpdtBBG1pipMltffhTlu9fAxisk4aeQHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MlFgMsKFzomBWmZgErSu+/LNgHMawQ73+FhZrmUm5mI=;
 b=udPjBgZJKBRezk1r+1QEP5HXoqTj+SJ2OZocOwMAPdvZfWTvGbJzOLXsMPwvnNcHhVvwVJmfp9XLIqD1Wa4uQ2MmaayNWADS5FmN0sG5wraC7KqdkrlRDr+Nx0Xml/eO7aZmgRuq6pGaPgq0JN8lFUyMLnhn8lkuCBDj8dyot9U=
Received: from TYUPR03MB7030.apcprd03.prod.outlook.com (2603:1096:400:35b::6)
 by SEYPR03MB6769.apcprd03.prod.outlook.com (2603:1096:101:68::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 02:32:26 +0000
Received: from TYUPR03MB7030.apcprd03.prod.outlook.com
 ([fe80::d123:8fa7:f0ee:3d1b]) by TYUPR03MB7030.apcprd03.prod.outlook.com
 ([fe80::d123:8fa7:f0ee:3d1b%6]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 02:32:26 +0000
From: =?utf-8?B?SmlhLWhhbyBCYWkgKOeZveWutuixqik=?= <Jia-hao.Bai@mediatek.com>
To: Pavel Machek <pavel@ucw.cz>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>,
	=?utf-8?B?SXZlcmxpbiBXYW5nICjnjovoi7PpnJYp?= <Iverlin.Wang@mediatek.com>,
	=?utf-8?B?Qm95IFd1ICjlkLPli4Poqrwp?= <Boy.Wu@mediatek.com>,
	=?utf-8?B?U2VpeWEgV2FuZyAo546L6L+65ZCbKQ==?= <seiya.wang@mediatek.com>,
	=?utf-8?B?RGVuZ2p1biBTdSAo6IuP6YKT5YabKQ==?= <Dengjun.Su@mediatek.com>,
	=?utf-8?B?V2luIFllaCAo6JGJ5piM5YCrKQ==?= <Win.Yeh@mediatek.com>,
	=?utf-8?B?U293ZWxsIFBlbmcgKOW9remmluWBiSk=?= <Sowell.Peng@mediatek.com>,
	=?utf-8?B?UmljaGFyZC1DQyBZYW5nICjmpYrogbfpipMp?=
	<Richard-CC.Yang@mediatek.com>
Subject: RE: [BUG] Kernel panic when using Hibernation on kernel 6.1.25
Thread-Topic: [BUG] Kernel panic when using Hibernation on kernel 6.1.25
Thread-Index: Adqw1J9Y/DIFBWg0SV+jdgPf4fUPYgMqxvYAAB520lA=
Date: Fri, 14 Jun 2024 02:32:25 +0000
Message-ID: <TYUPR03MB7030367311B22CA3580997FDC6C22@TYUPR03MB7030.apcprd03.prod.outlook.com>
References: <KL1PR03MB7037E7FDCC426ED77C917910C6F12@KL1PR03MB7037.apcprd03.prod.outlook.com>
 <ZmrPVg6PwlYLRiSS@duo.ucw.cz>
In-Reply-To: <ZmrPVg6PwlYLRiSS@duo.ucw.cz>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR03MB7030:EE_|SEYPR03MB6769:EE_
x-ms-office365-filtering-correlation-id: cf69bdc5-8072-4bdb-a23a-08dc8c1a3a96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230035|1800799019|366011|376009|38070700013;
x-microsoft-antispam-message-info: =?utf-8?B?eTZ2ZkZvUnAvbXBSVm5HZjllZjcvblFJSlp4SVBKSnN4YTNBRUxETDUrVnJy?=
 =?utf-8?B?K2hXdGpFckdWOVduS05aUDhyTHlmdHdKMHROVlpWb0NodHd0OC9zTS9nS3Zq?=
 =?utf-8?B?b2hPQUtqbGZIOVBWdFJGa29UVytOc0wxNGRRNC9Bc1FFb29oaGJlMms3N1g1?=
 =?utf-8?B?RWdOSEhBem5Qb3hTbWFQanhYdm5mMjdNUVJPZ1RCa0FqM0hWcVBsbmJyTE1h?=
 =?utf-8?B?MTF6Z3JWYjBBVjd2VjhwL2VCNnpvL0ROUys1NkZaTGtEUE02SUlzVGJMdDZD?=
 =?utf-8?B?U2JGdTN4cDk1QzNZd2YvbUNTWVpjZnI0UUswOXh4amNKeUxEWlZtamluV2lk?=
 =?utf-8?B?ekRyYWQxNkJQVVNVcm90YkFZMzRnNDJVZlRRNWo0aFZIVFVQZ0FQQURGb2VL?=
 =?utf-8?B?aW5SZFl0cEJIUlkzb3J6eHBtbytrTFkzaE1za1BZNTFTeWYySlhLbnFlNUhU?=
 =?utf-8?B?NWxzQUYwTGFXZVlaUk9PbXVPQ2k3S2UwT0t2UTREdDJmaEpVOFlHTy9SakJm?=
 =?utf-8?B?a0JWZUhVOExOWnZFczRNRFJsMmlTZS9QUWpqSndOTExoZWFjQnZVYUVSNmh3?=
 =?utf-8?B?NzNhT3dzaW9NTnVhUnJnZS9qVDZ2NXUvcG9tZStCUVBsYVFrZDUvZUlWUVRJ?=
 =?utf-8?B?cFRPZUZ5djYyM1lsNWNVSUFPR21WR2hnWWQ0R1N4RWxTdGw4Q0dmdjlZYURo?=
 =?utf-8?B?bDdXbnBqalIyRFcvangwMmtjM25PY3RWd1JKWVpEa1h1UmJUY1d6Ty8vVHdh?=
 =?utf-8?B?Z3lGd3B1WUdJejFlQ3k5aXVXT0E2SWNVdE1ESEZEK0RRTGVETm1paC9CdlhQ?=
 =?utf-8?B?SmZxSklVMUh3SDJYUkUzcWJ3elN1R3R3OHJKSERsckZCRHpNMThQbnlPUE9t?=
 =?utf-8?B?ZlQ1VVlXYS8wUXltOCs3ZWNYZnFPd2VIcTdqV1pBL0pWa1VrWVk2MEMrcit6?=
 =?utf-8?B?MUlWQWZEeGRpWXBsMXRNRlVHWjh6RC8yRG9xRlhVQTN0Vk5UNmYzbmdZSDU0?=
 =?utf-8?B?ME9NNUhZRHdMSW0rM3NuMUx5bHJLRWV6dWtPcVNvWkJLNmpxdVdVcGFoM3pk?=
 =?utf-8?B?QWpmWW56dktVc3JVckdhUERVbkgrZm54UEtFbk9Wam1mWXJudjBvbXZucHRR?=
 =?utf-8?B?c2VsbTdPMFFVZDBUNzc4VUpDMk91Tnh6elpGQU9OUWtuaGpXZTBRZkNmb0Nu?=
 =?utf-8?B?WmpVS3I0UElTTmpqOHpxZ1BjeGtOWk1xOHlKSmgyby91ZktsWUdzbnBEblN5?=
 =?utf-8?B?SHBiT2pDSnpLMTZOZmxtK1ZQV3lUNGk2b3AxeDJscW5zQmNyS2xsNkZNZ2I1?=
 =?utf-8?B?NXlOZ0lEMGJTaldOUlhnM0o2c1hBY01vM2tJM3A1d3VONTNnbmxDNDlKYVFo?=
 =?utf-8?B?cUZUenZIZHJjMCt0aDFIMnBpRDZNN2lEWGlqWmtrcGh0eWhJYk9EQVJRNkZw?=
 =?utf-8?B?UVhMNjhPVmNuQURQdHljZ1hxcDhnMm9kMWI4UmxBd0JEblhXVWxUUkxtRnZh?=
 =?utf-8?B?WmRzOURRMXY4TWdqNmlsSThLQVpRWXNpSEx0N2MyYUdWMDhkajAyMFV3dzR3?=
 =?utf-8?B?QXZiS2JlRjJhYzlBOURFeXdyTU92YWJ2MVRySVA4N2w0YW1DY3BZMmRxazl6?=
 =?utf-8?B?WTRqVE9hbitpeUg1MlhjSTFlNGs1a3lQUk0wK1djdUxLQ1l1M1BRK2FHRHkx?=
 =?utf-8?B?dzd5bFZiWnVlM0p5ZUlJSEc3QklRT1pNdFhqS3hvNGZSdFhRUDNBanJlUnBr?=
 =?utf-8?B?Unl4eWJIbTFDT2xRQUYrQms0dFRncHYzUisrN2IzUE1RZVd0R3d4bDRzTlFW?=
 =?utf-8?Q?SLfgkSAqQVSg3B/iUfylCbebKuJoAGetA5LMA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR03MB7030.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009)(38070700013);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFNWRkVKZ3c1WGVJdU4rcGprcnhGcmRNRitXYnhkZkduSmdXU3NuL3dPaGdW?=
 =?utf-8?B?T0gxSjQwR2lDZzdLR3cyRW1seTNaekk4OUlGbUs0VnhiY3ZxTEJRYUk0NXJE?=
 =?utf-8?B?M0pIZVlzUDM1TWRvdkIrZGgwbWxpVUpqYmtTSkZmWkw1OEt4QkxHTkhGRDZu?=
 =?utf-8?B?cEQ4SkdaYWZ1UE5qNlZJTWFkdFpYMG1Nd3pmZTQxTGFzYjdrSm16ODk2a2tL?=
 =?utf-8?B?OERQS0lOTVp2bGREclZ4SVhPd1hlTS8yNTVIM0Y3a2lCWU5md2F5UmR5RUtx?=
 =?utf-8?B?bjNLcWpZdDlNdzNVNHhKUmVRaFFCaGlGakpxZy9HbFJlZWdmbEdrTko1OVhu?=
 =?utf-8?B?RG5KVUF3bHRiWnVEYlU2cnBySFBTcDVTazNBVTFtZ3JxSTY5Zmp6UzRSM244?=
 =?utf-8?B?NWFpMXQ1ZE1ORjF0Yi95UWs3dE1iaWVXS0JYU2wwY3djTi80Q1dwYXdlTVVX?=
 =?utf-8?B?eVJkVEdpbGhVS2c2NGFLa3dRU3FNdjJrSTdzd0I1QlJzUXh2aEgzdGgzdng2?=
 =?utf-8?B?cS9VUkdid3NvR3JCejJyeFp3WkVUS2FHQ2dEMjN4NnN0cUdtN0c1b21MVjRn?=
 =?utf-8?B?Q29QTzNMdEVGOWcxbk5rZEdLMzVjODB6UDQzM1RaYnNOMDVkTjd3bGp5SkRv?=
 =?utf-8?B?M085QmoxMXZvU1hkZkNWbnVaS201cnJGTEQ2MzlUSElEZ2VSRWN1VENLR24y?=
 =?utf-8?B?ZjNMMmVQZ3cyVzFiK0J0YkNWckRWdkpPUkM3UG9jQVhHdGNRQm96ZFFPQ3R1?=
 =?utf-8?B?aS9qcEh5M2p6MkJ6MHJpSS9tV2p3VzNjZGlDTHovcEdBK0NKWVZySWlsMDM4?=
 =?utf-8?B?Tnp2MFFCdkhRd3dNNytzQTZ2MHlVUXpuME1oUHpEaDV3TXpvZUh4bDRhaklv?=
 =?utf-8?B?RExPY2JTeDNLeWVRUWVyTmFpN0pUSU1OUS8wRlhKbC9CdGRRQm1SZWtHSzB2?=
 =?utf-8?B?QnJqQU5ZVmdHRzdaRE9LR0dZUjJPNFpUOFJVSVNzK21XRXRabURjSVZjMDZU?=
 =?utf-8?B?NyttQjN4VEJiUWkzUHQyUGZqOU80bkg4QzBBMnJDTENDTTFmM2NhamE2STNq?=
 =?utf-8?B?UlNKRWpENTdGWkwzY2xOWnRMdGQ3NzZKQnVWTU50ellYZytjN1lSbnJlQTlw?=
 =?utf-8?B?NEdnZjlVc0dyNWhEeWk3WmJ1aTZXU3YvRGR4dm1hWXZmdFpmR3YzY0c1cGxG?=
 =?utf-8?B?RVFnOUlTbzNTYi8vcU9zMTJqMHNsMVNhTDMzaDdMRzBzUlJPa3pLLzQ1QnFr?=
 =?utf-8?B?eXlqKzdqa21TcElsU3NheVpNWVlEaXloak9xeEhZV2NvOG1RbWlaL0FQV3Mx?=
 =?utf-8?B?ZHBOZWVKcWJnZTFLM0NsalE2blVMUjQxdmpFZ09vSTJaU2h5UVlXWCtjOHVJ?=
 =?utf-8?B?TnVaNFZuc0x6WndzK05rUTJLVHFHQnZla0tNWVQ5SHUyTDVDUVlCd2tZN09h?=
 =?utf-8?B?NHBUT2NvUlFPTzNMZ1Z1SjVmcmhuMVBwRkJueG9NTU5mTVZkUXErMjdpZG5v?=
 =?utf-8?B?MVVDcFNmV0dBZFl6YUJtem9KbDZ6QnV6UDZwMDRPNUpVa0drcWdzNmo5VUdt?=
 =?utf-8?B?T3l3bnVBZFFQVy9COE9xMjdiT3VGbUliNTViWmFLQk5BeUh3SGFTRndXNzBC?=
 =?utf-8?B?d3pnM1hyT2poRldsQlNEaUFLZm44bTNSazB3a2NDWk5IU1dRVEs2c09ncC9v?=
 =?utf-8?B?eVJKeHV0V2RjRkJQazlHeXJnRFh5S1ZWc0Flei83Q3B0TGR4MGhkZGR3alJ5?=
 =?utf-8?B?a21YWUtHNU9RdEFVSVlCUXg2RU1VU2ZxSDlURno4Slk4TFE0ZzFyMU4xNGVU?=
 =?utf-8?B?Y3B5ZlQyc2F2MmxMdVFrV2xlZ1NCMU43QVYzQTZkNDIyMHgyblBrOXJoUk5B?=
 =?utf-8?B?S3ZwZjJaN2xvVnA1eDdyZGQwVWRkbjFHWjM0OUVIM0VETk9SUHJyTk9hanlX?=
 =?utf-8?B?ODdJcHJoUW80TTFyTkpDcVVYdisyVjdvS3A5MjRnQ0srajV0b0JwTlNlaHkv?=
 =?utf-8?B?cEgzMGZuZk5rRnJZamZiTzhjbUdvVjh5RFBkZG45bE5zQVJESERBaUgxSWdk?=
 =?utf-8?B?UDRVNkQwYXJWY2wzZjN1N1FzNUk3aDl3ODhvR1VqYzJnbVNhS3NLLzZWRzNz?=
 =?utf-8?Q?1FDQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYUPR03MB7030.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf69bdc5-8072-4bdb-a23a-08dc8c1a3a96
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 02:32:25.9267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I1hxX+PBNbhehb+oPVlu4PFs68dfLlt5QsKLomkVEswEVUCDNdFjeZo05rynRqtP7W80s2ASzkAApx46GuqKjwsbCbbpfh3G8oWZu+UaC5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6769

SGkgUGF2ZWwsDQoNCkhhcmR3YXJlOiBBcm0gQ29ydGV4IEE1NSwgMUdCIFJBTSwgZU1NQyA4Ry4N
Cg0KRXJyb3IgbG9n77yaDQpbIDEzNjIuOTg1NzAwXSBzaDogIG5vdGlmeV9kaWUgZnJvbSBkaWUr
MHgxNDQvMHg1ZjANClsgMTM2Mi45ODU3MDBdIHNoOiAgZGllIGZyb20gZGllX2tlcm5lbF9mYXVs
dCsweDEzOC8weDE0OA0KWyAxMzYyLjk4NTcwMF0gc2g6ICBkaWVfa2VybmVsX2ZhdWx0IGZyb20g
X19kb19rZXJuZWxfZmF1bHQucGFydC4wKzB4NWMvMHhhYw0KWyAxMzYyLjk4NTcwMF0gc2g6ICBf
X2RvX2tlcm5lbF9mYXVsdC5wYXJ0LjAgZnJvbSBkb190cmFuc2xhdGlvbl9mYXVsdCsweGJjLzB4
ZTANClsgMTM2Mi45ODU3MDBdIHNoOiAgZG9fdHJhbnNsYXRpb25fZmF1bHQgZnJvbSBkb19EYXRh
QWJvcnQrMHg0NC8weDFkMA0KWyAxMzYyLjk4NTcwMF0gc2g6ICBkb19EYXRhQWJvcnQgZnJvbSBf
X2RhYnRfc3ZjKzB4NGMvMHg4MA0KWyAxMzYyLjk4NTcwMF0gc2g6IEV4Y2VwdGlvbiBzdGFjaygw
eGMxZThkZjM4IHRvIDB4YzFlOGRmODApDQpbIDEzNjIuOTg1NzAwXSBzaDogZGYyMDogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYzMwMDAwMDAg
MDAwMDAwMDANClsgMTM2Mi45ODU3MDBdIHNoOiBkZjQwOiBjMzAwMTAwMCBlYTE1N2ZmYyBlYTE1
ODAwMCBjMTc2MzlhOCBjMTdiZDU0OCBlZGNlYjA2MCBjMTg0YjU0MCBjMTdiZDVhMA0KWyAxMzYy
Ljk4NTcwMF0gc2g6IGRmNjA6IDAwMDA3ZmQ3IGVkNzZjMDAwIDAwMDAwMDAwIGMxZThkZjg4IGMw
ZWJlNGRjIGMwZWJlNGU0IDgwMDAwMWQzIGZmZmZmZmZmDQpbIDEzNjIuOTg1NzAwXSBzaDogIF9f
ZGFidF9zdmMgZnJvbSBzYWZlX2NvcHlfcGFnZSsweDIwLzB4NGMNClsgMTM2Mi45ODU3MDBdIHNo
OiAgc2FmZV9jb3B5X3BhZ2UgZnJvbSBzd3N1c3Bfc2F2ZSsweDU4MC8weDVhYw0KWyAxMzYyLjk4
NTcwMF0gc2g6ICBzd3N1c3Bfc2F2ZSBmcm9tIGFyY2hfc2F2ZV9pbWFnZSsweDgvMHg3NA0KWyAx
MzYyLjk4NTcwMF0gc2g6ICBhcmNoX3NhdmVfaW1hZ2UgZnJvbSBjcHVfc3VzcGVuZF9hYm9ydCsw
eDAvMHgxOA0KDQpXZSBjb21wYXJlZCBiZXR3ZWVuIEs1LjQgYW5kIEs2LjEuMjUgYW5kIGZvdW5k
IHRoYXQgSGliZXJuYXRpb24gZG9lcyBub3Qgc2F2ZSB0aGUgcmVzZXJ2ZSBhcmVhIG9uIEs1LjQg
YmVjYXVzZSBpdCBpcyBibG9ja2VkIGJ5IHBmbl92YWxpZC4NCg0KVGhlcmVmb3JlLCB3ZSBoYXZl
IGFkZGVkIHRoZSBmb2xsb3dpbmcgd29ya2Fyb3VuZCB0byBza2lwIHNvbWUgcmVzZXJ2ZWQgbWVt
b3J5IHNlY3Rpb25zLg0KDQpUaGUgc2tpcCByZWdpb24gaXMgb2J0YWluZWQgZnJvbSAiY2F0IC9w
cm9jL2lvbWVtIi4NCjQwMDAwMDAwLTQyZmJmZmZmIDogU3lzdGVtIFJBTQ0KICA0MDAwODAwMC00
MTBmZmZmZiA6IEtlcm5lbCBjb2RlDQogIDQxMjAwMDAwLTQxNDRhMjVmIDogS2VybmVsIGRhdGEN
CjQzMTAwMDAwLTQ0MDJmZmZmIDogU3lzdGVtIFJBTQ0KNDUxNDAwMDAtNTkzZmZmZmYgOiBTeXN0
ZW0gUkFNDQo1OTQwMTAwMC01OTQwZmZmZiA6IFN5c3RlbSBSQU0NCjU5NDFmMDAwLTU5NGVmZmZm
IDogU3lzdGVtIFJBTQ0KNTk1MDExODAtNTk1ZmZmZmYgOiBTeXN0ZW0gUkFNDQo1OTY0MDAwMC03
ZmZmZmZmZiA6IFN5c3RlbSBSQU0NCg0Kc3RhdGljIHVuc2lnbmVkIGludCBwZm5faXNfcmVzZXJ2
ZWQodW5zaWduZWQgbG9uZyBwZm4pew0KCXBoeXNfYWRkcl90IHBoeXMgPSBfX3Bmbl90b19waHkN
CglpZihwaHlzID49IDB4NDJmYzAwMDAgJiYgcGh5czwgMHg0MzEwMDAwMCl7DQoJCXJldHVybiB0
cnVlOw0KCX0NCglpZihwaHlzID49IDB4NDQwMzAwMDAgJiYgcGh5czwgMHg0NTE0MDAwMCl7DQoJ
CXJldHVybiB0cnVlOw0KCX0NCglpZihwaHlzID49IDB4NTk0MDAwMDAgJiYgcGh5czwgMHg1OTQw
MTAwMCl7DQoJCXJldHVybiB0cnVlOw0KCX0NCglpZihwaHlzID49IDB4NTk0MTAwMDAgJiYgcGh5
czwgMHg1OTQxZjAwMCl7DQoJCXJldHVybiB0cnVlOw0KCX0NCglpZihwaHlzID49IDB4NTk0ZjAw
MDAgJiYgcGh5czwgMHg1OTUwMTE4MCl7DQoJCXJldHVybiB0cnVlOw0KCX0NCiAgICAgICAgaWYo
cGh5cyA+PSAweDU5NjAwMDAwICYmIHBoeXM8IDB4NTk2NDAwMDApew0KICAgICAgICAgICAgICAg
IHJldHVybiB0cnVlOw0KICAgICAgICB9DQoJcmV0dXJuIGZhbHNlOw0KDQp9DQoNCnN0YXRpYyBz
dHJ1Y3QgcGFnZSAqc2F2ZWFibGVfcGFnZShzdHJ1Y3Qgem9uZSAqem9uZSwgdW5zaWduZWQgbG9u
ZyBwZm4pDQp7DQoJc3RydWN0IHBhZ2UgKnBhZ2U7DQoNCglpZiAoIXBmbl92YWxpZChwZm4pKXsN
CgkJcmV0dXJuIE5VTEw7DQoJfQ0KCQ0KCWlmKHBmbl9pc19yZXNlcnZlZChwZm4pKQ0KCQkgcmV0
dXJuIE5VTEw7DQouLi4uLi4uLg0KDQoNCkRvIHlvdSBrbm93IG9mIGFueSBwYXRjaGVzIHRoYXQg
Y2FuIGZpeCB0aGlzIHByb2JsZW0/DQoNCnRoYW5rcw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KRnJvbTogUGF2ZWwgTWFjaGVrIDxwYXZlbEB1Y3cuY3o+IA0KU2VudDogVGh1cnNkYXks
IEp1bmUgMTMsIDIwMjQgNjo1MiBQTQ0KVG86IEppYS1oYW8gQmFpICjnmb3lrrbosaopIDxKaWEt
aGFvLkJhaUBtZWRpYXRlay5jb20+DQpDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
cmFmYWVsQGtlcm5lbC5vcmc7IEl2ZXJsaW4gV2FuZyAo546L6Iuz6ZyWKSA8SXZlcmxpbi5XYW5n
QG1lZGlhdGVrLmNvbT47IEJveSBXdSAo5ZCz5YuD6Kq8KSA8Qm95Lld1QG1lZGlhdGVrLmNvbT47
IFNlaXlhIFdhbmcgKOeOi+i/uuWQmykgPHNlaXlhLndhbmdAbWVkaWF0ZWsuY29tPjsgRGVuZ2p1
biBTdSAo6IuP6YKT5YabKSA8RGVuZ2p1bi5TdUBtZWRpYXRlay5jb20+OyBXaW4gWWVoICjokYnm
mIzlgKspIDxXaW4uWWVoQG1lZGlhdGVrLmNvbT47IFNvd2VsbCBQZW5nICjlva3pppblgYkpIDxT
b3dlbGwuUGVuZ0BtZWRpYXRlay5jb20+OyBSaWNoYXJkLUNDIFlhbmcgKOaliuiBt+mKkykgPFJp
Y2hhcmQtQ0MuWWFuZ0BtZWRpYXRlay5jb20+DQpTdWJqZWN0OiBSZTogW0JVR10gS2VybmVsIHBh
bmljIHdoZW4gdXNpbmcgSGliZXJuYXRpb24gb24ga2VybmVsIDYuMS4yNQ0KDQpIaSENCg0KPiBJ
IGVuY291bnRlcmVkIGEga2VybmVsIHBhbmljIHdoZW4gdXNpbmcgdGhlIEhpYmVybmF0aW9uIG9u
IGtlcm5lbCB2ZXJzaW9uIDYuMS4yNS4gQmVsb3cgYXJlIHRoZSBkZXRhaWxzIG9mIHRoZSBpc3N1
ZToNCj4gDQo+ICoqRGVzY3JpcHRpb246KioNCj4gV2hlbiBJIGVuYWJsZSBDT05GSUdfSElCRVJO
QVRJT04gYW5kIGFzc2lnbiBhIHNwZWNpZmljIHBhcnRpdGlvbiBmb3IgaGliZXJuYXRpb24gcmVz
dW1pbmcgYW5kIHBlcmZvcm0gYSBzcGVjaWZpYyBvcGVyYXRpb24sIHRoZSBzeXN0ZW0gY3Jhc2hl
cyB3aXRoIGEga2VybmVsIHBhbmljLg0KPiANCj4gQ09ORklHX0hJQkVSTkFUSU9OPXkNCj4gQ09O
RklHX1BNX1NURF9QQVJUSVRJT049Ii9kZXYvbW1jYmxrMHAxNiINCj4gDQo+ICoqU3RlcHMgdG8g
UmVwcm9kdWNlOioqDQo+IDEuCVNldCBwcmludGsgdG8gbGV2ZWwgODogYCBlY2hvIDggPiAvcHJv
Yy9zeXMva2VybmVsL3ByaW50a2ANCj4gMi4JU2V0IHVwIHRoZSBzd2FwIHBhcnRpdGlvbjogYCBt
a3N3YXAgL2Rldi9tbWNibGswcDE2YA0KPiAzLglFbmFibGUgdGhlIHN3YXAgcGFydGl0aW9uOiBg
IHN3YXBvbiAtcCAtMyAvZGV2L21tY2JsazBwMTZgDQo+IDQuCUNvbmZpZ3VyZSBoaWJlcm5hdGlv
biByZXN1bWluZyBzZXR0aW5nczogYCBlY2hvICIvZGV2L21tY2JsazBwMTYiID4gL3N5cy9wb3dl
ci9yZXN1bWVgDQo+IDUuCUNvbmZpZ3VyZSBoaWJlcm5hdGlvbiBtb2RlOmAgZWNobyByZWJvb3Qg
PiAvc3lzL3Bvd2VyL2Rpc2tgDQo+IDYuCVBlcmZvcm0gdGhlIG9wZXJhdGlvbjogYCBlY2hvIGRp
c2sgPiAvc3lzL3Bvd2VyL3N0YXRlYA0KPiA3LglPYnNlcnZlIHRoZSBrZXJuZWwgcGFuaWMNCj4g
DQo+IA0KPiAqKkV4cGVjdGVkIEJlaGF2aW9yOioqDQo+IFRoZSBvcGVyYXRpb24gc2hvdWxkIGNv
bXBsZXRlIHN1Y2Nlc3NmdWxseSB3aXRob3V0IGNhdXNpbmcgYSBrZXJuZWwgcGFuaWMuDQo+IA0K
PiAqKkFjdHVhbCBCZWhhdmlvcjoqKg0KPiBUaGUgc3lzdGVtIGNyYXNoZXMgd2l0aCBhIGtlcm5l
bCBwYW5pYy4NCj4gDQo+ICoqRW52aXJvbm1lbnQ6KioNCj4gLSBLZXJuZWwgdmVyc2lvbjogNi4x
LjI1DQo+IC0gRGlzdHJpYnV0aW9uOiBZb2N0byA0LjAgMzJiaXQvS2VybmVsIDYuMS4yNSAzMmJp
dA0KPiAtIEhhcmR3YXJlOiBBcm0gQ29ydGV4IEE1NSwgMUdCIFJBTQ0KDQpXZSdkIG5lZWQgdG8g
a25vdyB3YXkgbW9yZSBhYm91dCB0aGUgaGFyZHdhcmUuIEFsc28gdGVzdGluZyB3aXRoIGxhdGVz
dCBtYWlubGluZSB3b3VsZCBiZSB1c2VmdWwuDQoNCkJlc3QgcmVnYXJkcywNCgkJCQkJCQlQYXZl
bA0KLS0NClBlb3BsZSBvZiBSdXNzaWEsIHN0b3AgUHV0aW4gYmVmb3JlIGhpcyB3YXIgb24gVWty
YWluZSBlc2NhbGF0ZXMuDQo=

