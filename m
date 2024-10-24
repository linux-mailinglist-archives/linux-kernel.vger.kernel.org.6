Return-Path: <linux-kernel+bounces-379068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545759AD936
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 03:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09BB028358A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 01:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C0342070;
	Thu, 24 Oct 2024 01:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pO6SSl5j";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="mR9wmNhp"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B732014AA9;
	Thu, 24 Oct 2024 01:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729733335; cv=fail; b=YGWG3vIinenKCq0Y6L0iPl0rmnmhvtLAVYn6NEAMABMzSGFQ1ZToUamF+V6eBp4FGwUknh1881prmsBzbAh9yQBsRV7iA3Y+6FAVSP61rUTOjbHvgW1sJ8NPfVevJbP9uI8ZiQAOQKpVaqnTxzgM0IIgwqyZOPxua7K6+0jlTGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729733335; c=relaxed/simple;
	bh=5RmebftmmQ/ApESYvVHSvLZeXGX59UtgetA098SJheI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QZIRthov99a4i8uKj2HJ2zyZiVxSCR5chCAhFN0B4Vr9Q7cE+4Lvw7B0SE3X+oLg8ssFvFbf4hErbGT3+aA7Y/GJwOjT8wJ95YPAZ8z1C8nxFtIArA0EAptaefZ/W2mAoQli3EWz5UCh2PqzrUm7emtifpNfWLK81or4U/mnuLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=pO6SSl5j; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=mR9wmNhp; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 506e463091a711efbd192953cf12861f-20241024
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=5RmebftmmQ/ApESYvVHSvLZeXGX59UtgetA098SJheI=;
	b=pO6SSl5jve4x0Rz/QCpBsi3C0934Y5RqIyRN6XsMUu0u+qy470BYr85RR6adBeWp5hmye6imYl2C4IBvB4940HouYPKIIiLYfhAfkWgU5rcpp+mHDK5c47QEBpDDaDM7/3KTSf6OCXMlefXo+pwmGTFf9fUURZr8DRFFp8fjzQM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:67d01204-a589-4254-9676-e3540aee5e55,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:b0fcdc3,CLOUDID:2dabc4cc-110e-4f79-849e-58237df93e70,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 506e463091a711efbd192953cf12861f-20241024
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <friday.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 366573312; Thu, 24 Oct 2024 09:28:46 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 23 Oct 2024 18:28:45 -0700
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 24 Oct 2024 09:28:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bULb3IF1C3/eeRJMBtCLoKMD6K9Cj4TShdI08I+/GjuLWiHODiKa4pRtuEfva3aHXth0MTzJDEFLHYioNAIJ6RC60k45ziU821WODLKzTU9r1GoVQWWOekv51LLnYT3kZxUpeiV1N/QZTzYZ5J+RTEZrBVw0XCQwmv45ePIubI99hOcwoRvLX+pKMbgI/ErV0CCd0Ow/2SlfX0FjjE+HaIwt8E+DlEGPgZ7WAB2uWzQxecf/bPO93kN4PONCZBe7GJYAd//PR5O47kVuffeq3kEjRPKwuGoqDOnmM9CT7FQE9r1qKzaBfBuwwu4ktPXRj0v7O5V1E8yDOmCwEJ6zNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RmebftmmQ/ApESYvVHSvLZeXGX59UtgetA098SJheI=;
 b=Zvn5o/xF9u+G6Zs3vR4N77hjoFYGJIrJf2aAgMWd/p2gvExw28C8mvnN4Adg8wZKZmg+jNuHHOZlLWSwpvgDtJNJ4/eDo/mAX3h6/6P1okwQb9+1Ob1O53jB87T02jhn4Wq+KhPtnpwUG6iuvMxwZrohhmA+z9XONm3tbpiErY2fI2vWgaMJpnuhACwYi4cks0TrKB0HdoKy4d1r3LrzFyo787Q2pqrTZfV4EFxLAFDLQcvU/p2Dk4+9mzyc+1KTI9GQG/kZnmwLhHrOv8/2JD8N8noNvQ2E0dijm0KBSexQCFsIvprb+CCUYDGpo5roYb/Z0QqmhFff4eeA1I3sTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RmebftmmQ/ApESYvVHSvLZeXGX59UtgetA098SJheI=;
 b=mR9wmNhpuHLXkQGFaD1iY3vyxGtaddkUTu03TYDZz9B8j0qVyVhQx5KOdXWv7uH4YXBkXMxwyCdw2nK9azjqsAgVB3mmcAnsdWLjW6ssHftH8dSAYPkbah0h49XC/XBOxJMcjafl4FvXUHSbCO/2btLNQqrgJ/y7SBEd0/Kc5AA=
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com (2603:1096:990:3d::5)
 by JH0PR03MB7655.apcprd03.prod.outlook.com (2603:1096:990:d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Thu, 24 Oct
 2024 01:28:43 +0000
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f]) by JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f%3]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 01:28:43 +0000
From: =?utf-8?B?RnJpZGF5IFlhbmcgKOadqOmYsyk=?= <Friday.Yang@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"krzk@kernel.org" <krzk@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/4] dt-bindings: memory: mediatek: Add mt8188 SMI reset
 control binding
Thread-Topic: [PATCH 1/4] dt-bindings: memory: mediatek: Add mt8188 SMI reset
 control binding
Thread-Index: AQHa86RTZdMfi6vpcU+mcZhAXRt9zrIxaAsAgGQY3gA=
Date: Thu, 24 Oct 2024 01:28:42 +0000
Message-ID: <02881ae482cfe256b40955c81929a5f5ea72142b.camel@mediatek.com>
References: <20240821082845.11792-1-friday.yang@mediatek.com>
	 <20240821082845.11792-2-friday.yang@mediatek.com>
	 <ef942c52-9a07-4f32-92b8-cd96021ac451@kernel.org>
In-Reply-To: <ef942c52-9a07-4f32-92b8-cd96021ac451@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR03MB7983:EE_|JH0PR03MB7655:EE_
x-ms-office365-filtering-correlation-id: 1ed66430-8904-44c5-c2eb-08dcf3cb3271
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?S09aRlJzaXRUbmViUUI2aytjekQ4UnFzNEZ2RkJMNXJnemxDci84SC9QNnpL?=
 =?utf-8?B?YjFJa0RsbnRtelBjRlFYdzhaV01vNlBEc25maE1tR3ByQ011bFdjM1d1Mjkw?=
 =?utf-8?B?dDUrVStmYnRORE5XSlJKNG1JaitwU1B3MG9IQ1dzMDd1QjN3OXpVOEZSUmhU?=
 =?utf-8?B?aldmVlNrbjNjTlg0MUFwVjdmbFRsSnJCK0NJTnJEUGl1bCs1ZTE4OHdaNmFr?=
 =?utf-8?B?a3R3K2JvdEtmRUtOelNJSVU4TTlFdVN6MlFjVTd4TmtyekdCRWUrZFh0WUxI?=
 =?utf-8?B?ZlgvZmxzSnArblpJcHFWdFdqMXV6ZmVXWDBpeXlSa0l4NjN1b0t1b3locDVB?=
 =?utf-8?B?U0xsQnF5enFCQ3kxVUJkc2JrR3VGR3cwZmFtSzNZRUN6OG14RUI3Q0hGczN5?=
 =?utf-8?B?RjFNdWxQMnF3VTZGMTZGdUNDQzYySDdyR0tmWHFOdS9FWkhBeWVjNTBRdWlG?=
 =?utf-8?B?Q0YvcStMMlBwNEZnQVJpK290Y3hIVHRJbFpzZTR1aWE2YUdRd1Y3V3UyNDkz?=
 =?utf-8?B?RFFPTEhRVnVhdE1DL01EZW5ZODdMRWpRUjl5Tko0blVOeHppdTVMN3hwM3g3?=
 =?utf-8?B?V3VqS2FZV0x6SWVYSWprUmJHcnk2WmJpMHlucitsTmF3OGJuWXVOOFQ2YUJx?=
 =?utf-8?B?NUhwdi9YTlFqeTRrYW5EbUFmSlJIVSsrZTloeDVxVHQxUXZwUjgyNjdtdHpK?=
 =?utf-8?B?bUppZU5ILzNnZXE5WCtLNlFwSGhDL0F0QXpVYlU0WkthTXB1cEJUOWc4OU4z?=
 =?utf-8?B?dWhQSVRTWmhvSGlaY21QTXMwMEZveXpIMFlUclZpNDNJMy9WZStRelNiVFZD?=
 =?utf-8?B?UmxYRndhbm95SXA4V1Y1dURiaTlhUVBEWDNJRVJZRlNTek0zWnB1OFR3cUdt?=
 =?utf-8?B?eWlGWUV0VzcyTTByQ3Q2emx2UEsxSHRHWWNoN1VydGU4VUplcFk3dllyWWtl?=
 =?utf-8?B?dml0STh0d0d3WVl5ZVB4NVoxYXgrQjc5V2swUHoxK0JhV0d3RkJlYmRCU2hW?=
 =?utf-8?B?TXBsSk9sYlFzZzV1UmJMdnJEdkdhUnVtTHhySXdzb0xVTkc1UmE0SHVvV3VH?=
 =?utf-8?B?aHFhYnNSdFg5dEpWbUczWHRPdGYrbzlEK01RcHRyQ3JwZHNPNEdvTGUxeDlp?=
 =?utf-8?B?VDZtOXFXaXU4T3IzZEphdnB5b0N6eEZTblJIRGdNakJkUnI4dldOWkp2MkZE?=
 =?utf-8?B?RERRQkU4MW91K1BQM3BxSGhpeGFHTDJEK25UTURMc2g1cWRYWGdvWUh5UWdo?=
 =?utf-8?B?dHg3eHV1WWdJUlNEcVFSRitFWUNDcUlEUnZlRHE5Ni9TMnBnam51RXNSWVZj?=
 =?utf-8?B?cmlwTlNmRGJKM2MwRE05ZHBLdGIrZHlrc3JPM2EwcUdVMytVekdEYjRuSVVD?=
 =?utf-8?B?MW1USW80K2hReVMwYVAxTVQ0MHZ5WjhaQWdlR0prV0pTckd6K2k1VXd5QlIy?=
 =?utf-8?B?V3QwV0RoalZFVCtkQTZxUmtIMmFrM0I0SHZyN1BPWEN3SWZUa0JEZ0I1ZlVX?=
 =?utf-8?B?emtzOGZJTXhUbXdwdEZIODlacWZ5dHVXSVJuQThDaWQ1ZlpGTzJxS2U5N2ln?=
 =?utf-8?B?NWIvVWJhTXVtMDNSeXRNUkZCSjNpd2NWVHZxSTVLUXFhMktpenhaVEF0akhJ?=
 =?utf-8?B?ZmtsSGZGOVJ0SGgzTSszSlpqR2tSelkwR3QrYm9YalhXeGUxbWgyM1VhR0pJ?=
 =?utf-8?B?bjIrUWlGNVRWVld4MmhhWW5TbFVuazdQSnZCTWFWQnFoYmtGVlN1ZHUzalVk?=
 =?utf-8?B?ZFcrOE5KODIvK3RDY3Uvbm9LQ2ZqanZYd1QreFlpNTU0Nkt4ejZ2NWJ2Tzhw?=
 =?utf-8?B?ZEFtYk91d2p5Q2JwNGlQUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7983.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1NWeVV2UmUvK0NMbzNCbXl0RUFIQkUrMG1yc3dBMFBJQUVCUkF0QmJZa0Z2?=
 =?utf-8?B?SjJ6Qm5hRUpRU09RWWJRUHEvYW1KM01Eb1FXcWZ0NlczdHAwckFoL2NCQ1cz?=
 =?utf-8?B?RS95UUxQQkl0b3dWNm9qZi8zckh1YzNSUm1Sd3ZuM05IazdIaHlEdHFHdU5S?=
 =?utf-8?B?ODRZdnV4bzhEUXhEMFREMjVHU2JIbFl5OTNpdGpXQ2JmTzFobU1TS21VOUVv?=
 =?utf-8?B?OWx1S2pLb3NmajZwMFhYVzlEQWxNdHZPbjN1T1ZoZlJ6eWlIVGxEdjZWbks1?=
 =?utf-8?B?eVNnT1M0dFRuTUl1TDlSQWE1QjhqM2M3SkhHN1R3QzErNnA5TFlPeEZMNUtq?=
 =?utf-8?B?clNSMmdnTFdXSURkcGJaTE1TVDRMTXE0V3Vhakd6bGpkR3JDSHJTOFZVcXpv?=
 =?utf-8?B?V0dtYXY2SWN6cU9aVFBxYTVsWjh3dmtMMzVGNUJ5d0FXVERDUHIwQTFyMFRY?=
 =?utf-8?B?dnZvTjAzZi9UbWNIWGlkTGpweDRSTlkzcU1oZldmT05NMUk0Mm9BMXN3V3pm?=
 =?utf-8?B?Y1YvK1l1MVlOc291THpkeFJEWnFOcTBBZXlDNE9XWU5TNFB6eUhWbzlEVG1D?=
 =?utf-8?B?UEF5MjNJOWYwRnE1dWRVVFNQdWN4bVVnNWNSSU1rWGNSamdrMk1NUnc4cEM5?=
 =?utf-8?B?ZFNrVlpGbktPYWZwbEpsOGoyTHdFYTMxWHl1Vkp2MWhlNGdOS3k1SFNib1Iv?=
 =?utf-8?B?TE93ejF4cm1aSkZRdlIyamNZSGNUTHlDYk5GRDEwMDBVU3JGUEFlQjdvODVL?=
 =?utf-8?B?YzN1TDJLRnM5dXl3VGE1dXZmQUU1bXFiR09vekFJUUpqT1ZKR2hyNndvaVFk?=
 =?utf-8?B?KzkxMGNjQWVOV2Q0OHBZUGY3OVgzRHVvbkhlSHRNZmFGdi9BdGNkT25hU3Bn?=
 =?utf-8?B?SEtjbVFaSTh1RVFpUWZrUUdRNStHVXBydHErWkV2TG1WSEFRQ01SNzNOa21N?=
 =?utf-8?B?eWo4VlR2aUwzbFZPV2J6c1daQzRXNjRxOEY1RnNVL0REN09sR0x1K25Kd3lk?=
 =?utf-8?B?ZnhzNEVHRGtQSWNHS05kZFV2NC9nR2ZXdG10Nk5kcnV6TmFXeU51RmNEWmVD?=
 =?utf-8?B?U0N5VWYycW9sRlIxN1k5dXJPemgrVUFPMUFKVVd5RGwwb3pHRldiSWlodkxH?=
 =?utf-8?B?MVdjakIyWDBwMGU1amg2WTdXM2hGVnJOVjNkL1ZTZ3B4cEQySmhPcjIzbkhZ?=
 =?utf-8?B?NjdGZTJxbG9leDY0KzNvTFdLYk9NQ2crT1g0WnhkeTZDbGZIVHFNQkd3U2t5?=
 =?utf-8?B?UFU5c1dpSVppMXR2dXh3OVBmME5NV0tCU3h1bUlDMEVLT3BDaXVTaDBXU2Jz?=
 =?utf-8?B?enhRb0dvamNneWN3M3JHNXNlQXAyZHRna2hEMGF1VmxkdWg4OEN4Uk1IbVc0?=
 =?utf-8?B?R0huWG1LSlhvaEVMZzUwY0xtYmFTSXBNQ2kyZVdWNk5IdVVtdVNjTFdDMWtO?=
 =?utf-8?B?U2xVVzR2b21yOElabEg2Yis2MWhtNmJHRGxKK3piRVErNDBFbVo2QS9Td2gr?=
 =?utf-8?B?MFpPRjJXMGFHMUE3RHJOdXhPbHhDTHE2YUVNWlFPckYvQ2xqTkRrWDFHWU5x?=
 =?utf-8?B?a1YzTkErbVdOVGo5MUVjUGwvK1E4WlhjWW5YT3dJcFlGWWtDcGZzR1ZZSjM3?=
 =?utf-8?B?cDdjaDFTRGpCU1d5cVVGdWg0LzduOTByOS9SeGN6d1lVeExEY3NIZ2lpTitU?=
 =?utf-8?B?MkRHZ2JDQU9GOTl2VFlhYUVMK1hmUkUxbURlU1BLakZJZ1ZMSG1uL3krR1Uv?=
 =?utf-8?B?c29TeERMTGhZYVNZNVltODZqQVFwTVpQcFBzNXhuWkhVTTFIQkNrbnpmRVRS?=
 =?utf-8?B?TStVcVJWSVlnbndKRVdGMEIvUjI4Q28zcWdGR000WWsyOEtMMTlESGs3Q0Ru?=
 =?utf-8?B?bGJrUmw5TUtXVm0zb1VWdU5MZ3EyM29YQVlUYktocHRVK1BKdTlHanJmVCtL?=
 =?utf-8?B?NHhtekN1Sjg2RXkxYzNzcW5YQXVBcWx1Ymg1cDJQNnpYSTIxR3lETE5NS3R0?=
 =?utf-8?B?bHMxUFZYdUczTy9XMENMUmFIUVgvYndhWEZ5OGxQM1ozWE9COHN6K3RFSkRP?=
 =?utf-8?B?QkdsSUk0Z2cyKzFtUzVnT1FheXVKZ3hwT3VjSHZyZi9ob3REdCttRXpPZVJO?=
 =?utf-8?B?WVRCV0IxR1NjTEpvWTd5eXpBQ09yb2Yyc0IxMllDY29BNktJZmNmalNpMU81?=
 =?utf-8?B?R1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE6348349618C14580E1DCA857557F74@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7983.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed66430-8904-44c5-c2eb-08dcf3cb3271
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 01:28:42.9398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ELnk+OiHgLHba+L679dWssYgJeCYS8ktHaz0ZqJmS5LMCrDX9oP7GrLrj7H0KpH7bDI4pMksmpqLPBaKl+ezk8UAG0pw6QGfJHavp7VSBvw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7655

T24gV2VkLCAyMDI0LTA4LTIxIGF0IDEwOjU0ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gIE9uIDIxLzA4LzIwMjQgMTA6MjYsIGZyaWRheS55YW5nIHdy
b3RlOg0KPiA+IFRvIHN1cHBvcnQgU01JIGNsYW1wIGFuZCByZXNldCBvcGVyYXRpb24gaW4gZ2Vu
cGQgY2FsbGJhY2ssIGFkZA0KPiA+IFNNSSBMQVJCIHJlc2V0IHJlZ2lzdGVyIG9mZnNldCBhbmQg
bWFzayByZWxhdGVkIGluZm9ybWF0aW9uIGluDQo+ID4gdGhlIGJpbmRpbmdzLiBBZGQgaW5kZXgg
aW4gbXQ4MTg4LXJlc2V0cy5oIHRvIHF1ZXJ5IHRoZSByZWdpc3Rlcg0KPiA+IG9mZnNldCBhbmQg
bWFzayBpbiB0aGUgU01JIHJlc2V0IGNvbnRyb2wgZHJpdmVyLg0KPiA+IA0KPiA+IFNpZ25lZC1v
ZmYtYnk6IGZyaWRheS55YW5nIDxmcmlkYXkueWFuZ0BtZWRpYXRlay5jb20+DQo+IA0KPiBVc2Vy
IHByb3BlciBmdWxsIG5hbWUgaW5zdGVhZCBvZiBsb2dpbi4NCj4gDQoNClRoYW5rcyBmb3IgeW91
ciBjb21tZW50cyBhbmQgc29ycnkgZm9yIHJlcGx5aW5nIHNvIGxhdGUuDQpJIHdpbGwgZml4IGl0
IHRvIEZyaWRheSBZYW5nIDxmcmlkYXkueWFuZ0BtZWRpYXRlay5jb20+Lg0KDQo+IA0KPiBQbGVh
c2UgdXNlIHN1YmplY3QgcHJlZml4ZXMgbWF0Y2hpbmcgdGhlIHN1YnN5c3RlbS4gWW91IGNhbiBn
ZXQgdGhlbQ0KPiBmb3INCj4gZXhhbXBsZSB3aXRoIGBnaXQgbG9nIC0tb25lbGluZSAtLSBESVJF
Q1RPUllfT1JfRklMRWAgb24gdGhlDQo+IGRpcmVjdG9yeQ0KPiB5b3VyIHBhdGNoIGlzIHRvdWNo
aW5nLiBGb3IgYmluZGluZ3MsIHRoZSBwcmVmZXJyZWQgc3ViamVjdHMgYXJlDQo+IGV4cGxhaW5l
ZCBoZXJlOg0KPiANCmh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwvbGF0ZXN0L2Rldmlj
ZXRyZWUvYmluZGluZ3Mvc3VibWl0dGluZy1wYXRjaGVzLmh0bWwjaS1mb3ItcGF0Y2gtc3VibWl0
dGVycw0KPiANCg0KSSBoYXZlIGFscmVhZHkgdXNlZCB0aGlzIGNvbW1hbmQgYGdpdCBsb2cgLS1v
bmVsaW5lIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZXNldC9gSWYgeW91IHRo
aW5rIGl0IGlzIGluYXBwcm9wcmlhdGUsIGhvdyBhYm91dCB0aGlzIG9uZT8NCidkdC1iaW5kaW5n
czogcmVzZXQ6IG1lZGlhdGVrLG10ODE4OC1zbWk6IEFkZCBTTUkgcmVzZXQgY29udHJvbCBiaW5k
aW5nDQpmb3IgTVQ4MTg4Jw0KDQo+ID4gLS0tDQo+ID4gIC4uLi9iaW5kaW5ncy9yZXNldC9tZWRp
YXRlayxzbWktcmVzZXQueWFtbCAgICB8IDQ2DQo+ICsrKysrKysrKysrKysrKysrKysNCj4gPiAg
aW5jbHVkZS9kdC1iaW5kaW5ncy9yZXNldC9tdDgxODgtcmVzZXRzLmggICAgIHwgMTEgKysrKysN
Cj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA1NyBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2Rl
IDEwMDY0NA0KPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVzZXQvbWVkaWF0
ZWssc21pLXJlc2V0LnlhbWwNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3Jlc2V0L21lZGlhdGVrLHNtaS0NCj4gcmVzZXQueWFtbCBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZXNldC9tZWRpYXRlayxzbWktDQo+IHJl
c2V0LnlhbWwNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAw
MC4uNjZhYzEyMWQyMzk2DQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZXNldC9tZWRpYXRlayxzbWktDQo+IHJlc2V0LnlhbWwN
Cj4gPiBAQCAtMCwwICsxLDQ2IEBADQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChH
UEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KPiA+ICsjIENvcHlyaWdodCAoYykgMjAyNCBN
ZWRpYVRlayBJbmMuDQo+ID4gKyVZQU1MIDEuMg0KPiA+ICstLS0NCj4gPiArJGlkOiBodHRwOi8v
ZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9yZXNldC9tZWRpYXRlayxzbWktcmVzZXQueWFtbCMNCj4g
PiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwj
DQo+ID4gKw0KPiA+ICt0aXRsZTogTWVkaWFUZWsgU01JIFJlc2V0IENvbnRyb2xsZXINCj4gPiAr
DQo+ID4gK21haW50YWluZXJzOg0KPiA+ICsgIC0gRnJpZGF5IFlhbmcgPGZyaWRheS55YW5nQG1l
ZGlhdGVrLmNvbT4NCj4gPiArDQo+ID4gK2Rlc2NyaXB0aW9uOiB8DQo+ID4gKyAgVGhpcyByZXNl
dCBjb250cm9sbGVyIG5vZGUgaXMgdXNlZCB0byBwZXJmb3JtIHJlc2V0IG1hbmFnZW1lbnQNCj4g
PiArICBvZiBTTUkgbGFyYnMgb24gTWVkaWFUZWsgcGxhdGZvcm0uIEl0IGlzIHVzZWQgdG8gaW1w
bGVtZW50DQo+IHZhcmlvdXMNCj4gPiArICByZXNldCBmdW5jdGlvbnMgcmVxdWlyZWQgd2hlbiBT
TUkgbGFyYnMgYXBwbHkgY2xhbXAgb3BlcmF0aW9uLg0KPiA+ICsNCj4gPiArICBGb3IgbGlzdCBv
ZiBhbGwgdmFsaWQgcmVzZXQgaW5kaWNlcyBzZWUNCj4gPiArICAgIDxkdC1iaW5kaW5ncy9yZXNl
dC9tdDgxODgtcmVzZXRzLmg+IGZvciBNVDgxODguDQo+ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0K
PiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gKyAgICBlbnVtOg0KPiA+ICsgICAgICAtIG1lZGlhdGVr
LHNtaS1yZXNldC1tdDgxODgNCj4gDQo+IFdyb25nIHBsYWNlbWVudCBvZiBzb2MuIEl0J3MgbWVk
aWF0ZWssbXQ4MTg5LXdoYXRldmVyDQo+IA0KDQpUaGFua3MsIEkgd2lsbCBmaXggaXQgdG8gJ21l
ZGlhdGVrLG10ODE4OC1zbWktcmVzZXQnLg0KDQo+ID4gKw0KPiA+ICsgICIjcmVzZXQtY2VsbHMi
Og0KPiA+ICsgICAgY29uc3Q6IDENCj4gPiArDQo+ID4gKyAgbWVkaWF0ZWssbGFyYi1yc3Qtc3lz
Y29uOg0KPiA+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhh
bmRsZQ0KPiA+ICsgICAgZGVzY3JpcHRpb246IHBoYW5kbGUgb2YgdGhlIFNNSSBsYXJiJ3MgcmVz
ZXQgY29udHJvbGxlcg0KPiBzeXNjb24uDQo+IA0KPiBFeHBsYWluIHdoYXQgaXMgaXQgdXNlZCBm
b3IuDQo+IA0KDQpJIHdpbGwgYWRkIHRoZSBkZXNjcml0b24gbGlrZSB0aGlzLCBpcyB0aGlzIGNs
ZWFyIGZvciB5b3U/DQpXaGVuIFNNSSBsYXJiIHBvd2VyIG9uL29mZiwgd2UgbmVlZCBsYXJiIGNs
YW1wIGFuZCByZXNldCB0byBhdm9pZCBidXMNCmdsaXRjaCwgdGhpcyBpcyB0byBpbXByb3ZlIGJ1
cyBwcm90ZWN0LiANClRoZSByZXNldCBjb250cm9sbGVyIG5vZGUgaXMgdXNlZCB0byB1cGRhdGUg
cmVnbWFwIHRvIGltcGxlbWVudCBsYXJiDQpyZXNldCBmdW5jdGlvbi4NCg0KPiA+ICsNCj4gPiAr
cmVxdWlyZWQ6DQo+ID4gKyAgLSBjb21wYXRpYmxlDQo+ID4gKyAgLSAiI3Jlc2V0LWNlbGxzIg0K
PiA+ICsgIC0gbWVkaWF0ZWssbGFyYi1yc3Qtc3lzY29uDQo+ID4gKw0KPiA+ICthZGRpdGlvbmFs
UHJvcGVydGllczogZmFsc2UNCj4gPiArDQo+ID4gK2V4YW1wbGVzOg0KPiA+ICsgIC0gfA0KPiA+
ICsgICAgaW1nc3lzMV9kaXBfdG9wX3JzdDogcmVzZXQtY29udHJvbGxlciB7DQo+IA0KPiBEcm9w
IGxhYmVsDQoNCkkgc2VlIG1hcnZlbGwsYmVybGluMi1yZXNldC55YW1sLCB3aGljaCBhbHNvIGhh
dmUgYSBsYWJlbC4NCkRvIHlvdSBtZWFuIHdlIHNob3VsZCByZW1vdmUgaW1nc3lzMV9kaXBfdG9w
X3JzdCwganVzdCB1c2UNCidyZXNldC1jb250cm9sbGVyJyBoZXJlLg0KDQo+IA0KPiA+ICsgICAg
ICAgICAgY29tcGF0aWJsZSA9ICJtZWRpYXRlayxzbWktcmVzZXQtbXQ4MTg4IjsNCj4gDQo+IFVz
ZSA0IHNwYWNlcyBmb3IgZXhhbXBsZSBpbmRlbnRhdGlvbi4NCj4gDQoNCk9LLCBJIHdpbGwgdXNl
IHNwYWNlcyBpbnN0ZWFkIG9mIHRhYi4NCg0KPiA+ICsgICAgICAgICAgI3Jlc2V0LWNlbGxzID0g
PDE+Ow0KPiA+ICsgICAgICAgICAgbWVkaWF0ZWssbGFyYi1yc3Qtc3lzY29uID0gPCZpbWdzeXMx
X2RpcF90b3A+Ow0KPiA+ICsgICAgfTsNCj4gDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlz
enRvZg0KPiANCg==

