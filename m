Return-Path: <linux-kernel+bounces-199218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1508D83FB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622C41C22498
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB6B12D758;
	Mon,  3 Jun 2024 13:30:58 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF71839E5;
	Mon,  3 Jun 2024 13:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717421457; cv=fail; b=XdYQ2+/7CILym/rAv/IfbOccpscC0dN7cE4nHu/kzQ41gicCtQlO9eqjqmdt1f6bEvX5nWm2V0d+lwwzRdI7s58C1eq3fpUQvhcLrHmVM4JwtUh2k6a6EbFkMWU6LcYLrhKOCxPLiZ8nMBVQLIufAeE+H6QGCv81fCfcMu1UwJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717421457; c=relaxed/simple;
	bh=NTKhcYX6TiVoc2hlCBkm6g6m0S4bELHuLGL5TfHNjWU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version; b=h5YgWBtxDLIIwskyT5x4okeqk/Ui+lN14tW2ysZKb8emk2FfMDVqhGOD8RhwM4y+fmyn0euYHlvK/PDqLDaOngI07/ByJlbDV5w9JJHkU+qwtfzermXoIAKmb7JWx13ey3BKhjxmVKmjg0dmrDwZ1k9q8bV7zxqk85JOQbCuZLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 453Ci5QN024396;
	Mon, 3 Jun 2024 13:30:51 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-type:date:from:in-reply-to:message-id:mime-versio?=
 =?UTF-8?Q?n:subject:to;_s=3Dcorp-2023-11-20;_bh=3DNTKhcYX6TiVoc2hlCBkm6g6?=
 =?UTF-8?Q?m0S4bELHuLGL5TfHNjWU=3D;_b=3Dd5x4QrU6AJoXgJdJlJue/wb9LQc0QgXXuj?=
 =?UTF-8?Q?tOC+j2jgXLB7jF8ZQqpvxXM2wXv6RUnWG2_jJGt7LEdjELnpn4hviYCyJ5+Jxxp?=
 =?UTF-8?Q?d9weBLWPK9MsBJc5qNXqzI7I/ds40yO+SDKC/38j_9494VbCyNq1WqV8DCUUFB3?=
 =?UTF-8?Q?XQ4ja55Oz7aNfC5ujhAr2nNNPHs7wm3qtUrFtAAzo8QqKa_1HoOPJm26Xzbp7k1?=
 =?UTF-8?Q?egTT+NJzuzEKnoZ8dPp7BpMaBJt9TXcIXA79YCJ13j67VcPGbf2e_YDuxVNnyaD?=
 =?UTF-8?Q?HmWXDXeJA36WIGntH/x0Xzh4xVRqBjdblgSo2bg+htSbufhRkmngscdDNH_og?=
 =?UTF-8?Q?=3D=3D_?=
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfuyu2tvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Jun 2024 13:30:51 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 453Ca6Pn005608;
	Mon, 3 Jun 2024 13:30:50 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrmc5n5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Jun 2024 13:30:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3mlwVSwVq0pNp3U9jZqhZ5sy6As/67OzkT/eAg3SxlbjAPm6cfDFUzTrtGBXgYpMSwcMTkfq1VrYvoxz1v6z58FPqZiMQ5DZZAyduoG1qOAo4ggUJbJb819H9whtmFNUFpcBrI99pfaaQvWf166CahYrN4Nie2q7rFx9Bz1PDUNuIJaqRU29/A7Q8z4fb/a72G5n4F5whZrE1YWxegEgppSzExe53p/tc551vG7D7tqWTDgde6enCfizbmOX8KoGIIkvBfwORPMvfZhZJxLVcl+58R6CK/pPhGlAm2LnAjpMtsfJdd1SXRuwFkTaY0aQNsnlPtnJx3NdEzNii7Cdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTKhcYX6TiVoc2hlCBkm6g6m0S4bELHuLGL5TfHNjWU=;
 b=cMQIUJNZBi84/15y5XdetryDU9UcAhGvdmdZWFCmP0Pu7lMcF1oNPgjEZneLBSmDF8Rkgz1TmGV4FwKpvT/7VOSiJlr1wVySFa20pxt7qSRL+yT5N16vJbqzf7aQZaMvlcRMoKfBvYk3U/VdjqTIA0D9U5OLCKgelMBjJLxhke+3WAKVGFX5V/8MhPGIqvqI+Dt+1mGYaYzrhluPZnYp54PIdrhD0I15Kk4RaPyaejO/LQB4IvSOiJXlNvml+ypjw9/ZBZc03lX0cy49J1tIIKEbN9upt5Z3/fElKmOUk1oXGExlWvtoxaVPCRSHgQJ6YLtI1xTcV9sgt70CxbspDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTKhcYX6TiVoc2hlCBkm6g6m0S4bELHuLGL5TfHNjWU=;
 b=mxpulhYyd2pDDmVhwGKtpkfp92rLG8gA8Jw0Zgm2qEWef6fsFUE2wvzlZoyhecF/Yo9nhCDXc28c8MJ05BUA+9LzgBgwpipqvEhVV5X6CjkSMXvj6cmqk9jK3HdkUEpSnwFI7hbtjnnaAGM6krvJ6I6AtrZx5NMwdyMJAh454ds=
Received: from PH0PR10MB5563.namprd10.prod.outlook.com (2603:10b6:510:f2::13)
 by IA1PR10MB7387.namprd10.prod.outlook.com (2603:10b6:208:42d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Mon, 3 Jun
 2024 13:30:47 +0000
Received: from PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240]) by PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240%6]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 13:30:46 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "cve@kernel.org" <cve@kernel.org>,
        "linux-cve-announce@vger.kernel.org"
	<linux-cve-announce@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: CVE-2024-35812: usb: cdc-wdm: close race between read and
 workqueue
Thread-Topic: CVE-2024-35812: usb: cdc-wdm: close race between read and
 workqueue
Thread-Index: AQHatbo9LM0Ae7ulWUiU4CwLaFYSig==
Date: Mon, 3 Jun 2024 13:30:46 +0000
Message-ID: <629491b984d5618417a29c8eaf595f03b9bbe822.camel@oracle.com>
In-Reply-To: <2024051741-CVE-2024-35812-c804@gregkh>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5563:EE_|IA1PR10MB7387:EE_
x-ms-office365-filtering-correlation-id: 889a5f1e-df1a-4146-4834-08dc83d16069
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?ZEpKSEhlbmpwN0l2ajZad1pRMGduaVpxdzYwRXRXc2FJdXVUbzM4dWRRY2Yx?=
 =?utf-8?B?Ymh1QTBwRXozSmN5WHFqTHdkdXBWZHFSSStLRU05RmQ5WURmTmxmdmh6Zk9D?=
 =?utf-8?B?YVNzRlpCZzl5QXJWS2gxQkVrUkFVZlZOZm85dnpTcFJFczdxRHo4ZHU1elNY?=
 =?utf-8?B?dDR0VUFvZnFPbUxNelkwcGV2cUE1c2JBZytYV0ZEczJSeHE4VkxGa3h3ZlNB?=
 =?utf-8?B?SzY5WklUZmJ4bk5RL1FIbnR3M2FyWGgzQStERzVkOFFYQXlsRkE1YVZabXlw?=
 =?utf-8?B?V1ExTDZMdFlEM3ZLRXZ1T2FUL3BlN2ltREFoNHJxOFpaTU1lV1A4NStiaG1R?=
 =?utf-8?B?ZERWYkdIMTUvb1IvK25OMkM0cXJPemxPL2VqR2t3bTJJOFp2WVZwM0NucDJI?=
 =?utf-8?B?WXNZTEh4SW9FeXA1UlhOMzJwK0ZmdFZsSnZpc2lhZi9kMUVZL3RkWm91NXhS?=
 =?utf-8?B?SFAva2kwWmYxcEFjUXp3K1cwcTgzT1FvSk1OR3Q5K2RmTmd6WmFIU3NxR1VL?=
 =?utf-8?B?RFVQR0gzdHFva2UrWlk1bXY0akpUMG5BVzRzNlJTNmltWm1sM0JCdkwyVVk4?=
 =?utf-8?B?YVg4ZElyOHlVNDNlemNiT1B1L3NmMGQzWUJBZTNKT2t5R0Z0dHY2ZktaU1hZ?=
 =?utf-8?B?VHdBc3Bwd1hmbExwY2VSQ1ZWWFlTZUtlaEVoMWpXUEtuT3pjcFhQbzZZb0po?=
 =?utf-8?B?UmJNWlp2NHQzR1dEZGNOV0ttbk45QkZQUURqckFRdENNZlFHeDkzUFFwczZD?=
 =?utf-8?B?TVFMVFU0R0xGRFVPUjFCemNGeURZa1BzdEREUzNFd0FsaGFEVytvV3dJQ2I1?=
 =?utf-8?B?ZWpvZUFaRWpHeFlBRnNPd2swc0pEMG5vMmMwK2hLUlFoRlNwWjFsUDhTamJF?=
 =?utf-8?B?aU5xRXM3U0ZESE9QdTFqK0NWUlM1V2hjSklXNlE1a3Q1S2hoQzFTc3ZzUFRa?=
 =?utf-8?B?alNPdnlqY2ZtVFlUeUhEN3NKclowQzJheU9NdjFSYU8rNngxMVlLdzFsQkVw?=
 =?utf-8?B?S0Q4RkFaeFNING1JSloxYTVmVW9wYWRUbUJEQmVyZ1l6Q2JBaW9lQlU5Q3ln?=
 =?utf-8?B?ZjZNRWtBUWhiUUQ2Qkp4R2h4RmJDczQ2MnVtZDdySkI2UldZOFJPYVNWSnh3?=
 =?utf-8?B?MnRQdXlUVzRBUGo1UEE1a29CSHY3blJuMDY3OS9LTHZuRzI5UnlmcTFONmx2?=
 =?utf-8?B?KzhFcWNnYlM2d0VZL3RKVjgwRS9HZlVXdWlPL0hKSjQyOGVIdjJqSWh2ZDRO?=
 =?utf-8?B?ZmM1bWN6QmNEWk5zS0lqTkV1UDN0eE5FanFqeHNoSU11LzVkOWVndXczU3lL?=
 =?utf-8?B?MHdjRHJkM2ZrY0Y5bVpYcFVSOXRXUU85MkRzTmNKZkczK0VITDhKK05CaUdy?=
 =?utf-8?B?NDRZck5NUnVieFFyNHZ4THJESjRlbDZCR0FmZ1BPUjBiQnZiSDdoY09kbW5m?=
 =?utf-8?B?bXo2OEVvNmxYa1daSFI3NmhPZ1Z0OEtGMGtwQnpDOFovWGs5Y1Myc2sxcXk5?=
 =?utf-8?B?Y0JTYUtRZXZ1NmNCaVZSN2IrQ2E4VlhEMFJXMEcvNVFEQ1hTMGU4N1BKZGtX?=
 =?utf-8?B?QW96cmpiNGkzZ1ROaUh2RFVXWUNPdGFEaWVXOWlNR1pzd1diU1VoQzZTMngr?=
 =?utf-8?B?Vy9HNmZrcDBjN0xNT0h6U2pRNWZuN3kvT0lQaCtnQ3dKQ0lybVVweXIxNGox?=
 =?utf-8?B?VGxRWTJUd2RQbWNLSlo0QnhsQzlST1BzVUxlWnVjcGwvZVZPUUZ2ekIzamtQ?=
 =?utf-8?B?MXNuTXlGUEppTFhQM0c0Ty9FQlpSMHBpemFwMGY5NWV0elc4WXVlL0VKRjRD?=
 =?utf-8?B?NXQ0aDNxTHlNK1BZdGkzQT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5563.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?OWNwdXRHejBaUWxidWdyU0JCazBheFppajNjQmlRNjJZRXlnRDY2R01sVWxo?=
 =?utf-8?B?eW9IbU1MYnFoem5JSTA3N2d0UTFVMHpMYWlEVGF0cVVyUkJpTUR1SE9VbGgz?=
 =?utf-8?B?WjkxejNGLzNIbC94bit4S0xBQmdVMTJuK2ljVWM5ZGNPSDZSdWV4UElUc1ly?=
 =?utf-8?B?QmZRdGZXWksxUmNWSzdNSTgzbTJyWGR4anBSM0t4RVJLQ1ZqQjNSYnlncVFs?=
 =?utf-8?B?alVvWXl0MkZKQi8vcHYvYlc1Y3UyUGlBYThGREtIVnNFZE5wVVNaakhFZzBC?=
 =?utf-8?B?T1JJbVNSTFBDM0ppdTg1aFBzckc4K3RFZ2VyQzFUTjVBT3JmUlV1YytVYjda?=
 =?utf-8?B?LzZaaWFYMDFUQ21INTlDM2FiR3NHYll6Tk93UEZLZ005RkZwd0FTLzUwYVJX?=
 =?utf-8?B?UUxSdU1XejRUVWsvRGVxdUM4d0c1bmpZVGZYbFBodklodTkzS0N0ODBCbllN?=
 =?utf-8?B?WFY5UTJZbXpsWHJickFMN3NZUVlnL0VuZ2hhNmt5R0xwYkEvTW4zYi8ybmxR?=
 =?utf-8?B?RFl2WGZoRjZNTk5pZm1zWG9jdW5rQ09HVlNMd2hnMHZZbTZ2YzJRQnE4c3BS?=
 =?utf-8?B?N1lYNGV5WHlsa0lFV05sNlcreWtOQkNNZ0ZvdkJsbEtIZXZXUnA1ZE5sSkdz?=
 =?utf-8?B?L1psUU53SjVXTzQrZmMzOWNKWFJsei9HTkU3QWcvQU9VanZVaFkvdG40Tm91?=
 =?utf-8?B?UUt5RUp3YlZGN2wwNWRYb1FyV1VpT1Z2NHovU1FIL1orZEtIUkRmTUpTZUxn?=
 =?utf-8?B?ek5SYW5scXh1d1h1Nk4vNDl1clJvNEhERlhPYjZDZUQvSTdpVHRVS0N1ekZi?=
 =?utf-8?B?NDJsbFBKeXpmM1R3V0tPSlNBWkwrT2gwdUdnVXA2M3R4RnV0TWp1NzVTSFZo?=
 =?utf-8?B?U0FCKzUrWGswUVlYYVkvR1h0R1RzSzBwWDhhZjNJRk5adXhpMUpLSGhBTE94?=
 =?utf-8?B?Mko4TXRCS1RUTFRJUUkzMkN1TXNCVjlFOEZKR0tZNm5rWlZZMEhpL29zNXdx?=
 =?utf-8?B?MmF1WlMrY3Q1bjF0TjV2NU9CZnFXRG9VWnRRY3hHWktyV3dHTlV0U0x5cTVl?=
 =?utf-8?B?ald2b2tNK1N1dkdiVDdsZ1lUOTFXcXI5M3JBMWV1aUViQXkrS1Fvek5mRmVS?=
 =?utf-8?B?WFl3djFMT0F4WXMwUU1INllHYWR5NEUwR2FuOTd2TEVmZmZOaDhtYy9Ua0t0?=
 =?utf-8?B?WkNXQS94WXRFSnNnSlJnZDBEWTFZWmNsN0JrMFhMMDVOYkxqNmFUODA1R1gv?=
 =?utf-8?B?dElXQ3l1NVl5Nlo2SzJrUDg4WXRaQjhBVk9GalZ2d0NsRHorTFFmT1RERk5a?=
 =?utf-8?B?a3VmRThsL1YvZGJKZUR0eG8rTUpRaTFaUUNNUXpRMm5VdTdwWHUxUC9OUzNG?=
 =?utf-8?B?UHBtM0NaK05keklWTDZYaFVZQzQ4dDB6em1IZjRHQ0h4RFBwYjcwdHBjR1lM?=
 =?utf-8?B?UEk1QlJmSVpYcENaR0ZETE90SlhCaHJaOTEyMlBHcmpWcldlWlNoMHQzZzNV?=
 =?utf-8?B?bE8wT0IrUlhIRW50Vm9CRVRUMkJnbDdNSEVGUndWejVSTG1EMCtTR0ZWVjdI?=
 =?utf-8?B?Mm02TUJqMTNjMW1pRkN5a09XekZCekZQbVVtc1RnRTljanp1cEJrK3o1dmZi?=
 =?utf-8?B?Q2htQ0tKK2VlbVVDanI1QjlpVXIrcnhNUFlZU2lBLzJRZERQdmtPbnZvRkVk?=
 =?utf-8?B?K091VWljRi90dDJ6bmh1UmFhZm1FVFhIR2tqVHRxeW5nNStvRlNvQS9DcnF3?=
 =?utf-8?B?ZDg3ZUxPejlsMjdWK1N1SVdCSy80eEw0SGpQZVlUeDg3UTdDaGl5REsrcVFj?=
 =?utf-8?B?REVDeHRWUWIwbzZFM2RUYm40NWR5SUlqOTBIWnhiNzhRckVNV2xwK2NUUkE4?=
 =?utf-8?B?T2NhcjB2Uy8xbWxsa3M2ZFNDZWpPVnZxalRkbWUwQnpNN3pKVmptOWNTY1Qv?=
 =?utf-8?B?WXJ6SkpKN2FtZUxoeTdMNEZxcm5OaHY4MEMwV0pVZTRFM05Va0lIUDlUdnVw?=
 =?utf-8?B?SWRrcHlBMThNeTVENEpIUU1oZ05Lell6UlUzaFhMZWtLSWRPK1BrQlVnRWlC?=
 =?utf-8?B?SVNNQVlxdU9rNUZXQmE1RVBlalZnbHE5Qlp1UStHcDVoQjA2ZVJvNUF0bWgz?=
 =?utf-8?B?Q1lGUkErZlNXSDBDd2FJbjFTNlhKR3hUYURwVE1WTkNjQUNVdjFiMW85ekdQ?=
 =?utf-8?Q?8jZVenwGWlPHad7EF4i0x/MuKGYIEC1Q82C3blqAGizo?=
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-nfEsJD17hyx//aHZvomo"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/hBZVTADELZFflcq3SHFYLpqTjHox9TtE/IFzvlXo9biLx4Dp6CIecqaHVFzKC683gvXxu0S9SNIqrelMh8jLqVbnGumrHWsKyFbYWIfxAvghUJK+gcn+Jh5mi0BotLbsR+XoNrfzjyEWzqRiBTH7z/I6f9ME1VEgl/LusPJziigl921YJRYZ4t+SkhdA7k+uT2c45Ljc/11HGqB1zC8B1Hivly8w4dbHqA12mntw2OxqSFwhmCA6YJL5VauDbV6lICGdxdCZzCUMMYOw7hbKGyGzzr0F1zNFEm0mMuWLBZ9gje8kP6ytD3s1drP/CpHnS6OJhdTvvwvj2cNdFfz1MZxdl7tq1z+1yCpl/0+KCYG5F4+c8Gqs3b0MSbKTbsVbOzq0lQTgHeiM7LcClVvsGjZs436c2TQ6k3e5a2jXGBByakOiUKndZYufTbrMfmQF4H2iTIRiEjTV6FLq4vUQn7A4KJM7/FzNs9qEcIGC5yHafTeRceGrcGqAcmuefdrATLYdXpDkYDhSFcXFV8g+pQANZR8fPSUq2jCKZ01kOeeUvI+f2ZTD73DY23CrjB3GVRnjibXcNmee23EJfqzj0kmvhr5gj7izGssGlF7tow=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5563.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 889a5f1e-df1a-4146-4834-08dc83d16069
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 13:30:46.8371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3+9yZDaHVR4n239fkxLSl/y+Q50u2nG3/FbhCxUWA1djPIQWCW4Lus1YKkbcxB41U6c0IvIKsA7jPk+IN4kJ/Cb7vjybYhWxPJq3SRBJrS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7387
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_09,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=945 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406030112
X-Proofpoint-GUID: 7fZ0Lj28_X2AyxiApf2xm1cK0kkaIzh7
X-Proofpoint-ORIG-GUID: 7fZ0Lj28_X2AyxiApf2xm1cK0kkaIzh7

--=-nfEsJD17hyx//aHZvomo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 17 May 2024 15:23:52 +0200, Greg Kroah-Hartman wrote:
> In the Linux kernel, the following vulnerability has been resolved:
>=20
> usb: cdc-wdm: close race between read and workqueue
>=20
> [...]
>=20
> The Linux kernel CVE team has assigned CVE-2024-35812 to this issue.

This commit has been reversed in stable trees as it introduces a regression=
.

Thanks,
Siddh

--=-nfEsJD17hyx//aHZvomo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmZdxXkACgkQBwq/MEwk
8iozwg/9H8/+5Tjq5+I1aeMgXZntv0IBh86fwJpLmf3o9r8XRATzQfcagabbtCQ9
GKiJgIspVW3tRLbZEq/rNp4yx+TtWa1fHxzx4ZnsKeExoCy4f+qXvuufers0GTzH
BGl3lvmF65yn1W8d99gxyQ7hH33lSDFdYag1J9v4LR4LUq49/THOBMlEYdCEOJSj
dk9I+BoewbwAxjG8e5+7U4r08WfkIHBIm8YzJxLuqq9/PX94dPbEtYnEZaVl8rNq
gg9HNp9izUPNvb5l8Dne7edVpgTgBiCi6/MRWSFpUJObqEfEyQpk776fewkoKUMj
AQicH7ef4Qdq5N2hIIK70MPfSYQd7r9F3Ta4NOBBo3nvhAL6+elv1V/Ke9mu5WLE
i07oq64w3OoNs98CrjMmtd3iMDpYM3n7jqhRo3d0tTzDY16sFtJZZMKFbk1NXa4C
gbRtciaKZG6YgzUPCa27dj/OpQJkWgRff11hLgpoEcOOBdkMF2Cwa0e6PaAhb1F8
CQgRCVGukMhcifsunv1km8fypCgvXjBwkc83tO2WI59/fStaV5lYAAYxrVLNyu9Q
8tNraeyKKus0sMFHvhF7ZFEjKAO+wjQzkPh7BAO4tkbIsIIR/6siJmoZs3nA1vJh
hqXPVby1fgejzCSDIhzwn/xRAX9sDeu0d3X8St48EJe3DQOjDp0=
=1uz6
-----END PGP SIGNATURE-----

--=-nfEsJD17hyx//aHZvomo--

