Return-Path: <linux-kernel+bounces-383926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6427D9B2201
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 02:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7C921F21710
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 01:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0878D1537D7;
	Mon, 28 Oct 2024 01:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="PrQMH+DH"
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C5C2AD14;
	Mon, 28 Oct 2024 01:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730079018; cv=fail; b=lfQlrXsGOZo8mGIrGctTxZSj6qAV/xDKy5ZKk2MwI3713i9QQMJDG50CtO7AbHLpCtuqqinM5S8bbOouChrC2aLk9Ke+l8vFcYLgfL9eYCe50ajaSkfZt4uJrm/SAWDipiMktiFviCwi09wfdhgD/ZyW/i6xa0DzI6xR03iToJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730079018; c=relaxed/simple;
	bh=qjy6nJU2qN10eCWQPd456S1kZ7mT1J6c5sq2JkHbZd4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q7eFuMiTM4XoLe4oSuUFN3c8ySbFLLZz2gZkZiNvnRDxq3/+DhoZvWCSgnSOnEnZcbUSngXIk2pKCWQEhaiZHAztbhYXG6b3pgZeMCNDWmfRqOISguSv2eYyzSKNtXyOfsCnkR2OPHOxwA7fYnEn5rrFDFQm0u4fvbHut/cWzHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=PrQMH+DH; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209328.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49RNrvQU018474;
	Mon, 28 Oct 2024 01:30:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=qjy6nJU
	2qN10eCWQPd456S1kZ7mT1J6c5sq2JkHbZd4=; b=PrQMH+DHXatD5qxAaeMlHYe
	R4s7HfH9n4w+fafBh5+epSPEXSX7MSTD028OuUAJCR1QfhAz4B8nB6aP4aQvnVXG
	BKXlTP6gLoyovacEGmlH3zVO7b4khwegP7V7ll++ismxxP6yugPymdPJ1j7W2K4U
	PrX/FmqpaML3uhjpPtukh+h2rS+Tv/vuYbi2fkbryYj6n2p+rM3xCdYlfUiPdWew
	LeguBvoMMMlDs5e+7NOstkJxJis3zBhTyQB52jQikAHCHn+FrzlnwpwEusM3KgCC
	GH7Yqce0ogLv1WJbdkrXqnquFr2koVFxRVoVmsH9J5HQUqIwsEvpLsv/9ZrbTFg=
	=
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 42gskg964s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 01:30:02 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Coao1neeygHUSSRm3O9mbEMqolr7JRHHikYU+QzizlL/1iI3iyuDwwPR1xDnFIJCGv0d5UTGSNkJZS/rdZ2nrLkkyxXgpW3MAV53ws66RiqdHBYIW9hRYAUnUFj9mr1ibE95T2A9L/p2NWlUXtYWffCI97WSONIhxvMuQqFd2vuIU1H87tT1blk2kq75hn9CU8RTmwquBH5NFTD/dLPIjCg6LIksLiTa3rWZzb2ewIvX3R24F61nxc9DB7cl0Ly47ONwN+/kWAJi4kGI8D9Y75q5BusF08DklfKowogaMFHdP+Hjy7v2/enTuA3Aqbs9pYq65N30rsLCK/wrFxXzzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjy6nJU2qN10eCWQPd456S1kZ7mT1J6c5sq2JkHbZd4=;
 b=flro+KyxOR0w3ci6ne2DsscYveUE1ipRhKe7zo+4p164l/m4PXFVwVwhk5IHPH9VP5Vu7rM8olURur+9KvxkCNzJC2FSfjPd+YHGoDHbmpZdlyxrdcZ7UckeRMNYRpbFjaaRQksIyu17DuKCM8tbX9OD2d02h20c/x40SZbMeRfqkRkNyWHF2xRdMRu4xN436Fn15ak0cq8PKqvc45S8VQBw9RHAtudbUKX9obMf8cvb1psuh1hZ0BQv3e0+A9Z0339M5LS4zUvQxMyak3WKE3LHff1Nd9Is/Kb4XNX60MD44RoCYY9K0pqwESHzgdgadc23p2BUU39aPCtOEdVZmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from MW5PR13MB5632.namprd13.prod.outlook.com (2603:10b6:303:197::16)
 by CH2PR13MB3878.namprd13.prod.outlook.com (2603:10b6:610:93::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Mon, 28 Oct
 2024 01:29:57 +0000
Received: from MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::df7c:a5b9:aa3e:9197]) by MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::df7c:a5b9:aa3e:9197%6]) with mapi id 15.20.8093.018; Mon, 28 Oct 2024
 01:29:57 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: Saravana Kannan <saravanak@google.com>
CC: "linux-embedded@vger.kernel.org" <linux-embedded@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Boot-time initiative (SIG) thoughts and next steps
Thread-Topic: Boot-time initiative (SIG) thoughts and next steps
Thread-Index: AdsnCeBneydgAwbrQsOuFQyqBOu5BAAb/amAAFavyuA=
Date: Mon, 28 Oct 2024 01:29:57 +0000
Message-ID:
 <MW5PR13MB5632E4EFFD802E0839027A51FD4A2@MW5PR13MB5632.namprd13.prod.outlook.com>
References:
 <MW5PR13MB5632321E93B031C0E107DB38FD4F2@MW5PR13MB5632.namprd13.prod.outlook.com>
 <CAGETcx_c2nfFQ++-FcsdUdLUo3e-oe07MkLgbuyrnq2FPrcsXQ@mail.gmail.com>
In-Reply-To:
 <CAGETcx_c2nfFQ++-FcsdUdLUo3e-oe07MkLgbuyrnq2FPrcsXQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR13MB5632:EE_|CH2PR13MB3878:EE_
x-ms-office365-filtering-correlation-id: d784a88f-83ba-4458-2605-08dcf6f0088b
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OHdBQ1pVWFd3VE5kTUE1WitaVXhRTFV6UUx2WEVLT3kwTFA3emJVMHVMUm02?=
 =?utf-8?B?REpKcGdxMDJzWE1BTXR2ME80YzlHeWRGTzVsdVFGSUl6K08remRCc0pDYzRh?=
 =?utf-8?B?RTk3Yi9KYW1JUUc1ajRlR0pXdWFYbDVZRVlnZ3RxaEY5Z2wrL2JJczdlWE5Q?=
 =?utf-8?B?czdkQ3pUdFlyTWdjd2JqV1A0NU92SjZJU1JoTndVLytxdmI3a2RyaStYVG15?=
 =?utf-8?B?VGE0YWsrdUljOGF2Yi9EYmd0ZjlWdVdoOVJSOElOcTIzOUYwdExUYjNRb3Nq?=
 =?utf-8?B?cGlSV1pWaWdqWCtYenpEeEhJdXZ5T2FzdHdTL1l6WVEvZnlWMHZYZHNLR1RX?=
 =?utf-8?B?VzBJU29jcGZFbE1xenpFN2Y1NExZOTUreU83NGg5OEhvMXJ1bi9rRk5jaEpR?=
 =?utf-8?B?L2F6eVhNbTBvVkdQemhYa1Bhc3lxVWNTeXJlNzlXQkQyUHppd0tGanh5OU0x?=
 =?utf-8?B?ejFuaVlpbFEwQXg3aGt6RnM2bVlaSEJIYlgrTHAxMFQ1SEdWVUd4NFNQQmNy?=
 =?utf-8?B?ei9WWFk2OGxhcTZrNWZwMkxSc1lXY21FZGZVZ01RVlV2eThxSlVEL2RQUDVx?=
 =?utf-8?B?ZWF0cS92M09TZ0EyNG54OWhDdS8vRFpvMzliUllWNjI1RWo3NnpVUDJOK1BS?=
 =?utf-8?B?VlJOa0R3WkJYSzBNWVdXTnRHUTFodGROeWVndEdtNDRmVUlGbjJHL3h4eEJI?=
 =?utf-8?B?b2R6a1NTUCtVeitSalUvK3JPb3poMnh6a0xkRHlPZ043bW9CdHhlSDRESzQ1?=
 =?utf-8?B?YjhsMWhyN1k2a0oxM1ViQzI3dkMvNUI5VXR6T1dzd0pETW5uRHFOTDhicnVy?=
 =?utf-8?B?TzA3V2lOWXU1cnk5UFlBTXZsekpUVTJDZEw3VlFEMnoxM3hadWw0dTllWGFO?=
 =?utf-8?B?OUVCSG8zVC9UZnd0WDk4bmVtQmxOdFY5N3FBbmVtYVphMm00a0l0K2kwMXBR?=
 =?utf-8?B?bXJzYTJLZkZkd3ZvOGIzTjhzeHVoQVhFc2dTRk5TbVRyeUVMd05MRUlIckdi?=
 =?utf-8?B?WWxYTXExeC9ldFpYUUhSWjNsamtCMUFIb0tLS3hwT2xxSXdUdlNhMVlFVDRP?=
 =?utf-8?B?dDVMb082L2VsaFdXTHZhWjQyT01qYVV5UWZzSEFldFBqL1RTL2hFaWE5R0c4?=
 =?utf-8?B?TGlpV3JKSkxRVU8rR1pWajVJQnFoRlBwMy9yNUJhOEF2TEV0YXA2Q3FoTjBD?=
 =?utf-8?B?dGxDTThqUjQvRzkvaWFpeGJReEszT1NPbFphVFJ0eGw0QjVWY29JdUxwbzBo?=
 =?utf-8?B?Qm8yQ0VMekZaNDVZRDFwZGhDdkRaL1RhWTJwS1E3bk1IQ25vb3BVYjR6eFly?=
 =?utf-8?B?dzVTMWdSQVQzQzQrZjV2Y25PbnV5MHQ5ZlBYZDAxSXpObk43NEZlbGNTOEww?=
 =?utf-8?B?eHZIRTJVTkFZaHU0VjE4SStBVjNxMWZ1TTNacko2cGhnWGJ2QTVHWVZoNGN2?=
 =?utf-8?B?VzlwUUZyYTMzekxiM3ZzaXNoMFQ2L0RiYzcvV0NuK3d4MUc0eXNJbGQ3VGRz?=
 =?utf-8?B?YjBGbUM5M00zVVBReTBWeE1NK3BmM1Fsb1d2cDgxamw4TkJ4V1piMUdBMHYr?=
 =?utf-8?B?Qk52Y2VkZEtqdDMyQUlqZ01zb2xsbjdUZnpqdk9FS3YrTGN4L2puUFhMa1g4?=
 =?utf-8?B?RDlMTmRLRmxyc0NzbU9uQkJ5WXF3K2tCOXlZbzR1M0RHcENWMTN5MFM3VWFh?=
 =?utf-8?B?UGl2TWRMa004WU5FOExGWGRQSzd5S0tZZjFqSjhHL093cFdCTVEzcGdsZmp1?=
 =?utf-8?B?c0ZJd3k3UlB1dStHemhDQnNXMTA3VHVaYkpoeSsvTnBNSFlYaEp5a0d0VS9G?=
 =?utf-8?B?MUhjV1M0QjlBRkhxbStXRzdsN29HbzJseFlneGQ1TmplYmp0Q3lveCsxalIr?=
 =?utf-8?Q?f+d1LAPaXzgty?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR13MB5632.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?blYxb3pXZEhSOGFxSnIycWc3bDdDcUZGTllMcnJFOXpLS2ZjbHR2c0dUMnZr?=
 =?utf-8?B?ZVdxY0NHbVRaN3FtTldCaHB2d0hKUlNhOEp1dGVUZ29UOVBoWU0wcVdCSEVn?=
 =?utf-8?B?ZUZpQUl6WVNMZjEyYmNFajg4Rll5OVZCRmkvUW1mQmFpRzUzQUJHcTlPd0p3?=
 =?utf-8?B?VlpjQkQ5UndkZUZ5QmF5Skpwbjg4TzFRR3lpb3dkcVRGdXNnRWZDR3FQb0tC?=
 =?utf-8?B?a0gxb1gwcmVZNGxtcnNFYzYrcHR3L2tGc0ZCcjVVZHBVVnBCQzJjZUxZcGFW?=
 =?utf-8?B?bnpwRWZVQlNmdlBMa25xMTF4c2hhNjhzN05GWVRWTjgrbVRqT0FEN2hESzhn?=
 =?utf-8?B?YmdXKzhuZzdITHhqYXA1bTNkV09heWVuSmFNTmY2VExNVlhiUjVuOHo3WHBw?=
 =?utf-8?B?QjkyY0l5bUZ0Z01qVXhwR2JWUDhMalBRUWJOcGlGMzkrR2dyL0tUZGpFZ1Jo?=
 =?utf-8?B?ZlRYdDFEMlYvcXhUQVhYMG93TlpIOGU3TWp1VkJYTWZMSEN5N21VK1BzcUMz?=
 =?utf-8?B?R3IrZTRCQ3dzVEMrZDdka1pDVFg0NlNxenZmM25VNUU2d0hWVmZBWDF6eStX?=
 =?utf-8?B?QU93d08wQVFlUkFVR1RjWlhTZmhKS3NhcjNhNzZ3d3paTEtHZ0hSWUhBY1k0?=
 =?utf-8?B?dDUzemFwRXBQYzFoUTc2SHFIdDN2NENPQVlnRVdCZnVLcE1qQjdPMFB1S3Nw?=
 =?utf-8?B?dTJnSWxMdnlSejViVkRuNm9VUTFLRWk5enJZZVdpdStVem9WbkdTd3FveWVT?=
 =?utf-8?B?VzhiRFlCKy9jSXNhYVZleXRRQmI3N2xkdmFOeDAxOUEwcGg5YlZKVEFTczRY?=
 =?utf-8?B?WS9idlI2ZzgreE5hZS9MalpEeVRpWEVLbVFhVUExa0U2dU1OUlBRb3I5SzFs?=
 =?utf-8?B?eFNhRW1RQ2puS1RadnJ0aU82VWJ6VE1pbUFiUnIrTThncFFSOExhRGpFZk9V?=
 =?utf-8?B?bTdoMDdxTVNDSTRSTzFGaXI3TlNYSTNhKyt0cFJXRTI1cE4xbWh5S3pPZXdk?=
 =?utf-8?B?OXpxL0FLUUZSTnVmZE1lU3RPckpDM1d2ZHBmKy9LOTljWldoUVFLUEdSaks0?=
 =?utf-8?B?eWFMYno5MGQ3OW11cnVaWHdsaUlyVUdZb1djMlFmb1ZpTW41Q0t6bEk0NjBk?=
 =?utf-8?B?aDdvbkExYyt2UVFyYjAwTlZKWkdQV09tZ0d5bTh6NFkyNmFsUjc1OGtLdXFz?=
 =?utf-8?B?MHZoMzJRVEZCSVRBbzlGVHdvYlpGNy9FeUhNbUZ6bjVQTVJDM3FUSXI4OVFJ?=
 =?utf-8?B?S2w5R2VxOHdIblVJV0RndHBzYzlCVElKU0xkYkQ4ZXRudzF5RFgrb20rNW9B?=
 =?utf-8?B?U2pqYmtEY3FJRWpSbGFUd0lrOWVhZzJDOFEzQk5kTnpsdlQzQjBSZ1d5QTFR?=
 =?utf-8?B?YXBlMUllY1ZoRXNTN1RkeDhPei9Gano1N0FKeGVVRzBKS3YwRlFCamlGNWFn?=
 =?utf-8?B?WGJHVWxhSnFnWWhYZC9kSTNGNVFBTFBxTVF1VTVkalVMR1R5VzV6eDFSTDIw?=
 =?utf-8?B?all5VW5SbVlZWlQ2Ukc2dUgwWW1CYm02cDJJcFM4blp4SitFTUU1UGt5bXFn?=
 =?utf-8?B?MnhLOVd3bHUva2plTVpwTmJ1emlkMEFTSWZNUHZnYVI5KzdWa3RYaEJ5TWdM?=
 =?utf-8?B?NW1FUCtIdGVSRkJqNko0c1RMNm10NVlOdnNOeHIxV2EzSnZndk91VXVpejI5?=
 =?utf-8?B?MHEyNS9henp1dTliRzlFWHlhZm40N3MrSmJua01td0hxdzhhUE4zdEdjd2dk?=
 =?utf-8?B?b2FVa09tUUlsR245RFVJYjVvTTFSOTdwWXhiTFpkOTdkS0dsVFBmcElQbWxm?=
 =?utf-8?B?TmNkRm1wNTg0NVZzMHNqNnUrelF5a1RyQzY3aHl1UjErWVRYZ1VLMm05ejZJ?=
 =?utf-8?B?eVRVTU13QVNwd2swa1FHWTdQWlRTK0NXdFRyeExnR1NPY0lQNm1Edll3VFVh?=
 =?utf-8?B?Q3RDd0R4a1dkeVNlOTJOcFdpa0MxUjJPWHNsUXY3amwwdER6ZTVuMFNwWC9u?=
 =?utf-8?B?aE9rOVZDQXhqQ2xYVkcvamgwVlJvUTV6OGZlZXY2WDVlKytURTc0c2lyM0pk?=
 =?utf-8?B?akFzblBpaFVJa3JMa2xxWUtEQ0pkckpETjhHcFplSUo1V3FVc1pqbVBpQ1ho?=
 =?utf-8?Q?iOjF7X4afgJa2cti5nqiL/eK9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Dt/9F53ziyWciPweEsZyXTEmZV4GgvmAOlUScnjxsnvI2mj8+Ixixu2/uqFjm4u8MOZbxxQgzOnWubE7gHkQzGyoINi0R8u3RhgOC+EO0exKKJQFNj0DxvHtM5lUGrySX8yCQyYGfO+oQTPupy9+wZE/MmvVu2PG3560L/utcQxTpDKDgP0imqunfIeo+19BT/J3iK34xKHnu5ntNDPoYhXDGzgujRWJi2jv/26yTZUkZgOHArNjFItDmpstKls3pFtlhwZtGwNI3SIOVxrOftSXjdLi8B7G5+7HPCDWFgGy3A7hBUGY2ED6bAgspTvfIk72xFsIBF3ZEq5x7TKzLSgWKGGAmfR91xSXuNaMV3avk4vUEF8W4iJ4ZftBLnJl0jCZwDmJ/qQnVFAYbAv64McwGCGGNopDJgJalLbaLRufBFeSF85+UhvX8EtuJ3wQeya5tclMJbaF/L71bnLt6QrkYPYwJWs+RJdnqKDBhKItZxYViJ6m1QmUsBNXQZ/dFAsmnf+NQkyQ0tbGVO2X5H03XC7gQOD7HkXrXFfOQBT+ipDdarRKK81QACgFl3GZnf01TxcY1DTzFrwkVgIXOikc3G7PjNLZvoceXRA+fsJgUFl/fzvePyNpsRnhHTwX
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR13MB5632.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d784a88f-83ba-4458-2605-08dcf6f0088b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 01:29:57.5579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: va/60MLniIUE+nlGzhnl9xShb4msmdfzuITH9gvDYRLiVMZ5paM8Xg7n0hsm5Ufxgqo1yMwSngnToQ+onXZpdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3878
X-Proofpoint-ORIG-GUID: HolY117CaGkPeJ7DT7d2LydUgMDW41yI
X-Proofpoint-GUID: HolY117CaGkPeJ7DT7d2LydUgMDW41yI
X-Sony-Outbound-GUID: HolY117CaGkPeJ7DT7d2LydUgMDW41yI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-27_08,2024-10-25_02,2024-09-30_01

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2FyYXZhbmEgS2FubmFu
IDxzYXJhdmFuYWtAZ29vZ2xlLmNvbT4NCj4gT24gRnJpLCBPY3QgMjUsIDIwMjQgYXQgMTE6MTji
gK9BTSBCaXJkLCBUaW0gPFRpbS5CaXJkQHNvbnkuY29tPiB3cm90ZToNCj4gPg0KPiA+IEhleSBM
aW51eCBkZXZlbG9wZXJzLA0KPiA+DQo+ID4gVGhlIHJlc3BvbnNlIHRvIG15IHJlcXVlc3QgdG8g
Zm9ybSBhIFNwZWNpYWwgSW50ZXJlc3QgR3JvdXAgZm9yIGJvb3QtdGltZSByZWR1Y3Rpb24NCj4g
PiBmb3IgTGludXggaGFzIGJlZW4gcmVhbGx5IGdyZWF0LiAgTWFueSBwZW9wbGUgY29udGFjdGVk
IG1lIGJ5IGUtbWFpbCBhbmQgb24gTGlua2VkSW4uDQo+IA0KPiBIaSBUaW0sDQo+IA0KPiBUaGFu
a3MgZm9yIG9yZ2FuaXppbmcgdGhpcyBhbmQgbW92aW5nIGl0IGZvcndhcmQhIEknZCBiZSBpbnRl
cmVzdGVkIGluDQo+IGNvbnRyaWJ1dGluZyB0byB0aGlzIGVmZm9ydCBhcyBhIGxvdCBvZiB3b3Jr
IEkgaGF2ZSBkb25lIGFsaWducyB3aXRoDQo+IHRoZSBnb2FscyBvZiB0aGlzIGVmZm9ydCBhbmQg
Ym9vdCB0aW1lIGlzIG9mIG9idmlvdXMgdmFsdWUgdG8gQW5kcm9pZC4NCg0KVGhhbmtzIGZvciB5
b3VyIGludGVyZXN0LiAgSSB3b3VsZCBsb3ZlIHRvIGhhdmUgZGV2ZWxvcGVycyBmcm9tIEdvb2ds
ZSwgDQphbmQgZnJvbSB0aGUgQW5kcm9pZCBjb21tdW5pdHksIGludm9sdmVkLg0KDQo+IA0KPiA+
IEkgaGFkIGhvcGVkIHRvIHB1c2ggb3V0IGEgc2NyaXB0IHRvZGF5IHRvIHN0YXJ0IHRvIGdhdGhl
ciBkYXRhIG9uIGJvb3QtdGltZSBvbiBkaWZmZXJlbnQNCj4gPiBwbGF0Zm9ybXMsIGZvciBwZW9w
bGUgdG8gcnVuIHdobyBoYWQgZXhwcmVzc2VkIGludGVyZXN0IGluIGhlbHBpbmcgd2l0aCB0aGlz
IGVmZm9ydC4gQnV0DQo+ID4gSSBnb3Qgb3ZlcndoZWxtZWQgd2l0aCBvdGhlciB0YXNrcywgYW5k
IEkgbWF5IG5vdCBnZXQgaXQgZG9uZSB0b2RheS4gIEknbGwgYmUgaW4gVG9reW8gbmV4dA0KPiA+
IHdlZWsgZm9yIE9wZW4gU291cmNlIFN1bW1pdCBKYXBhbi4gIElmIHlvdSBhcmUgdGhlcmUsIHBs
ZWFzZSB0cnkgdG8gY2F0Y2ggbWUgYW5kIHNheSBoaS4NCj4gPiBHaXZlbiB0aGF0LCBJJ2xsIHNl
ZSBob3cgc29vbiBJIGNhbiBwcm92aWRlIHRoZSBzY3JpcHQgSSdtIHRhbGtpbmcgYWJvdXQsIGFu
ZCB3ZSBjYW4NCj4gPiBkaXNjdXNzIHRoZSBnb2FscyBhbmQgZGVzaWduIG9mIHRoZSBzY3JpcHQu
DQo+ID4NCj4gPiBBIGNvdXBsZSBvZiBxdWljayB0aGluZ3M6DQo+ID4gVGhlcmUgYXJlIGxvdHMg
b2YgdGhpbmdzIHRvIGRpc2N1c3MsIGJ1dCBoZXJlIGFyZSBhIGZldyB0aGluZ3MgdG8gZ2V0IHN0
YXJ0ZWQgd2l0aC4uLg0KPiA+DQo+ID4gPSB3aWtpIGFjY291bnQgPQ0KPiA+IFRoZSB3aWtpIHdo
ZXJlIHdlJ2xsIGJlIG1haW50YWluaW5nIGluZm9ybWF0aW9uIGFib3V0DQo+ID4gYm9vdCB0aW1l
LCBhbmQgYWJvdXQgYWN0aXZpdGllcyBvZiB0aGUgYm9vdCB0aW1lIFNJRywgaXMgdGhlIGVsaW51
eCB3aWtpLg0KPiA+IFRoZSBwYWdlIHdlJ2xsIGJlIGZvY3VzaW5nIG9uIGlzOiBodHRwczovL2Vs
aW51eC5vcmcvQm9vdF9UaW1lLg0KPiA+IElmIHlvdSBhcmUgaW50ZXJlc3RlZCBpbiBoZWxwaW5n
IHVwZGF0ZSBhbmQgbWFpbnRhaW4gdGhlIGluZm9ybWF0aW9uIHRoZXJlDQo+ID4gKHdoaWNoIEkg
aG9wZSBhbG1vc3QgZXZlcnlvbmUgaXMpLCB0aGVuIHBsZWFzZSBtYWtlIHN1cmUgeW91IGhhdmUg
YSB1c2VyDQo+ID4gYWNjb3VudCBvbiB0aGUgd2lraS4NCj4gPiBJZiB5b3UgZG9uJ3QgaGF2ZSBv
bmUsIHBsZWFzZSBnbyBoZXJlOg0KPiA+IGh0dHBzOi8vZWxpbnV4Lm9yZy9TcGVjaWFsOlJlcXVl
c3RBY2NvdW50DQo+ID4gSSBoYXZlIHRvIG1hbnVhbGx5IGFwcHJvdmUgYWNjb3VudHMgaW4gb3Jk
ZXIgdG8gZmlnaHQgc3BhbWJvdHMuICBJdCBtaWdodA0KPiA+IHRha2UgYSBmZXcgZGF5cyBmb3Ig
bWUgdG8gZ2V0IHRvIHlvdXIgcmVxdWVzdC4gIEl0J3MgdmVyeSBoZWxwZnVsIGlmIHlvdQ0KPiA+
IHB1dCBhIGNvbW1lbnQgaW4gb25lIG9mIHRoZSByZXF1ZXN0IGZpZWxkcyBhYm91dCB0aGlzIGJl
aW5nIHJlbGF0ZWQgdG8NCj4gPiB0aGUgYm9vdC10aW1lIGluaXRpYXRpdmUgb3IgU0lHLCBzbyBJ
IGNhbiBkaXN0aW5ndWlzaCB5b3VyIHJlcXVlc3QgZnJvbQ0KPiA+IHNwYW0gcmVxdWVzdHMuDQo+
IA0KPiBDYW4gd2UgaW5zdGVhZCBrZWVwIHRoaXMgYWxsIGEgcGFydCBvZiB0aGUga2VybmVsIGRv
Y3MgaW5zdGVhZCBvZiB0aGUNCj4gd2lraT8gQ291cGxlIG9mIHJlYXNvbnMgZm9yIHRoYXQ6DQoN
CklkZWFsbHksIHdlIHdvdWxkIHB1dCBzb21lIG1hdGVyaWFsIGluIHRoZSB3aWtpLCBhbmQgYWxz
bw0KcHJvZHVjZSBhIGRvY3VtZW50IC0gc29tZSBraW5kIG9mICJib290LXRpbWUgdHVuaW5nIGd1
aWRlIiB0aGF0IGNhbg0KbGl2ZSBpbiB0aGUga2VybmVsIHRyZWUuICAgIFNvbWUgb2YgdGhlIG1h
dGVyaWFsIHRoYXQgSSB0aGluayB3ZSB3aWxsDQptYWludGFpbiB3aWxsIHJlZmVyIHRvIGJvb3Qg
c2VxdWVuY2VzIGFuZCBvcGVyYXRpb25zIG91dHNpZGUgdGhlDQprZXJuZWwgKHN1Y2ggYXMgdGhl
IGJvb3Rsb2FkZXIgb3IgdXNlci1zcGFjZSksIHNvIHRoZSBzY29wZSBvZiANCnRoZSBtYXRlcmlh
bCB0byBkb2N1bWVudCBpcyBub3QganVzdCBsaW1pdGVkIHRvIHRoZSBrZXJuZWwuDQpBbHNvLCB0
aGVyZSB3aWxsIGJlIGEgbG90IG9mIG1hdGVyaWFsIHRoYXQgd2lsbCBiZSBzeXN0ZW0tc3BlY2lm
aWMuDQpIaXN0b3JpY2FsbHksIHRoZSBrZXJuZWwgaGFzIGF2b2lkZWQgZG9jdW1lbnRpbmcgdGhp
bmdzIHRoYXQgYXJlDQpzcGVjaWZpYyB0byBhbiBpbmRpdmlkdWFsIHBsYXRmb3JtLg0KRmluYWxs
eSwgYSBsb3Qgb2YgdGhpcyBpbmZvcm1hdGlvbiB3aWxsIGJlIGFkIGhvYywgd2hpY2ggYWxzbyBk
b2Vzbid0DQpsZW5kIGl0c2VsZiB0byB1cHN0cmVhbWluZy4NCg0KU2VlIG15IHJlc3BvbnNlIHRv
IHlvdXIgaW5kaXZpZHVhbCBwb2ludHMgYmVsb3cuDQoNCj4gLSBTaW5jZSB0aGUgaW5zdHJ1Y3Rp
b25zIGNhbiBiZSBrZXJuZWwgdmVyc2lvbiBzcGVjaWZpYyAoYXMgdGhpbmdzDQo+IGNoYW5nZSks
IGl0IG1ha2VzIHNlbnNlIHRvIGhhdmUgdGhlIGRvY3VtZW50IHN5bmNlZCB3aXRoIHRoZSBrZXJu
ZWwuDQoNClRoYXQncyBhIGdvb2QgcG9pbnQuICBUaGUgY3VycmVudCBtYXRlcmlhbCBzdWZmZXJz
IGZyb20gbm90IGJlaW5nIHN5bmNlZA0KdmVyeSB3ZWxsIHdpdGgga2VybmVsIHZlcnNpb25zLiAg
VGhhdCBpcywgdGhlcmUgaXMgYSBsb3Qgb2Ygb2Jzb2xldGUgbWF0ZXJpYWwuDQpNeSBvd24gZXhw
ZXJpZW5jZSBpcyB0aGF0IGtlcm5lbCBkb2N1bWVudGF0aW9uIGFsc28gaGFzIGEgYml0IG9mIGFu
IGlzc3VlDQp3aXRoIGJlaW5nIGtlcHQgdXAtdG8tZGF0ZSwgYnV0IGl0J3Mgbm90IGFzIGJhZCBh
cyB3aWtpcyBvZnRlbiBnZXQuIA0KDQpJdCB3b3VsZCBiZSBnb29kIHRvIGhhdmUgc29tZSBwbGFu
cyBhbmQgcG9zc2libHkgbWVjaGFuaXNtcyB0byBhZGRyZXNzDQp0aGUgZXZlbnR1YWwgb2Jzb2xl
c2NlbmNlIG9mIHRoZSBtYXRlcmlhbC4NCg0KPiAtIEl0J3Mgb25lIGxlc3MgYWNjb3VudCB0byBt
YWludGFpbiBhbmQgbGVzcyBjaG9yZXMgZm9yIHlvdS4NClRoZSBjb3N0IHBlciBkZXZlbG9wZXIg
aXMgb25lLXRpbWUsIHdoaWNoIHNob3VsZG4ndCBiZSB0b28gYmFkDQpmb3IgaW5kaXZpZHVhbCBk
ZXZlbG9wZXJzLiAgSSBhbHJlYWR5IGhhdmUgdGhlIHJvbGUgb2YgZWxpbnV4IGFkbWluaXN0cmF0
b3IsDQphbmQgc28gSSBoYXZlIHRvIGFwcHJvdmUgYWNjb3VudHMgYW55d2F5LiAgSW4gZWl0aGVy
IGNhc2UNCihjb250cmlidXRpbmcgdG8gYSB3aWtpIG9yIGNvbnRyaWJ1dGluZyB1cHN0cmVhbSks
IHRoZXJlIGlzIGdvaW5nIHRvDQpiZSBzb21lIG92ZXJoZWFkIGZvciByZXZpZXdpbmcgdGhlIG1h
dGVyaWFsLg0KDQo+IC0gT25lIGxlc3MgYnVzaW5lc3MgYXBwcm92YWwgdG8gZ2V0IGluIHRlcm1z
IG9mIGNvbnRyaWJ1dGluZyB0bw0KPiBleHRlcm5hbCBzb3VyY2VzLg0KVGhpcyBpcyBhbiBpbnRl
cmVzdGluZyBwb2ludC4gIERvZXMgR29vZ2xlIGhhdmUgcnVsZXMgcmVnYXJkaW5nIGNvbnRyaWJ1
dGluZw0KdG8gd2lraXM/ICBUaGF0IGlzIGFjdHVhbGx5IHJlbGF0ZWQgdG8gbXkgcGxhbnMgdG8g
dXNlIGF1dG9tYXRpb24gdG8gY29sbGVjdA0KYm9vdC10aW1lIGRhdGEuICBNeSBwbGFuIGlzIHRv
IGhhdmUgdGVzdHMgdGhhdCBhdXRvbWF0aWNhbGx5IHNlbmQgZGF0YQ0KdG8gYSBjZW50cmFsIGNv
bGxlY3Rpb24gc2VydmVyICh3aXRoIGRhdGEgdGhhdCBpcyBwdXQgaW50byBhIHNoYXJlZCwgcHVi
bGljIGRhdGFiYXNlKS4NCkkgcmVhbGl6ZSB0aGVyZSB3aWxsIGJlIHNvbWUgY29tcGFuaWVzIHdo
byB3b24ndCB3YW50IHRvIHNoYXJlIGNlcnRhaW4NCmRldGFpbHMgb2YgdGhlaXIgaW4tZGV2ZWxv
cG1lbnQgcGxhdGZvcm1zLiAgV2hlbiBJIHB1Ymxpc2ggdGhlIGZpcnN0IA0Kc2NyaXB0IHRoYXQg
ZG9lcyB0aGF0IChwcm9iYWJseSB0aGlzIHdlZWsgb3IgbmV4dCksIHdlIHNob3VsZCBkaXNjdXNz
IHRoZQ0KcmFtaWZpY2F0aW9ucyBvZiBkZXZlbG9wZXJzIG5lZWRpbmcgY29tcGFueSBjb25zZW50
IGZvciB0aGlzLg0KDQo+IC0gTGVzcyBjaGFuY2Ugb2YgYml0IHJvdC4gQXMgcGVvcGxlIG1ha2Ug
Y2hhbmdlcywgdGhlIGRvY3MgYXJlIHJpZ2h0DQo+IHRoZXJlIHRvIGdvIGZpeC4NCllvdSBhcmUg
cmlnaHQgdGhhdCBiaXQgcm90IGlzIGEgc2lnbmlmaWNhbnQgcmlzayB3aXRoIHdpa2lzLCBiZWNh
dXNlIHRoZXJlIGFyZQ0Kbm8gbWVjaGFuaXNtcyB0byBhdXRvbWF0aWNhbGx5IHVwZGF0ZSBvciBy
ZW1vdmUgb2Jzb2xldGUgbWF0ZXJpYWwuDQpJIGhhdmUgc29tZSBwbGFucyB0byBmaXggdGhhdCB3
aXRoIHNvbWUgdGVzdCBpbnN0cnVtZW50YXRpb24gYW5kIHVwc3RyZWFtDQp3aWtpIHByb2Nlc3Nl
cyB0aGF0IGNhbiBhdXRvbWF0aWNhbGx5IGRldGVjdCBjaGFuZ2VzIHRvIHB1Ymxpc2hlZCBkYXRh
LA0KYW5kIGNhbiByZWNvbW1lbmQgcmV2aWV3IG9mIG1hdGVyaWFsLCBvciBmbGFnIGl0IGFzIG9i
c29sZXRlLg0KDQpNeSBvd24gZXhwZXJpZW5jZSBpcyB0aGF0IGl0IGlzIHNpZ25pZmljYW50bHkg
ZWFzaWVyIHRvIGNoYW5nZQ0Kc29tZXRoaW5nIG9uIGEgd2lraSwgdGhhbiBpdCBpcyB0byBjaGFu
Z2UgdXBzdHJlYW0ga2VybmVsIGRvY3VtZW50YXRpb24uDQpPbmUgcmVxdWlyZXMganVzdCBjaGFu
Z2luZyB0ZXh0IHVzaW5nIGEgd2ViIGZvcm0sIGFuZCB0aGUgb3RoZXIgcmVxdWlyZXMNCmFuIHVw
c3RyZWFtLWNvbXBhdGlibGUgZS1tYWlsIGJhc2VkIHN1Ym1pdC9yZXZpZXcvYXBwcm92ZS9yZWxl
YXNlIGN5Y2xlLg0KDQpJJ20gaW50ZXJlc3RlZCB0byBsZWFybiBtb3JlIGFib3V0IHRoZSBiYXJy
aWVycyB0aGF0IGRldmVsb3BlcnMgYXQgR29vZ2xlIChvciBvdGhlcg0KY29tcGFuaWVzKSBtaWdo
dCBmYWNlIGluIG1ha2luZyBjb250cmlidXRpb25zIHRvIGEgd2lraS4gIENhbiB5b3UgZGVzY3Jp
YmUNCnRob3NlIG9ic3RhY2xlcyBpbiBtb3JlIGRldGFpbD8NCg0KVGhhbmtzLA0KIC0tIFRpbQ0K
DQoNCg0K

