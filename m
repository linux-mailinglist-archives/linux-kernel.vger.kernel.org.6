Return-Path: <linux-kernel+bounces-185668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0773D8CB8A4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 03:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B106128411F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 01:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEBEC8F3;
	Wed, 22 May 2024 01:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="mXRF5/WU";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jwv90+j6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="qU3nhvfS"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7975221;
	Wed, 22 May 2024 01:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716342132; cv=fail; b=uaEiIEHwnZmZUNNZ3mONS2rwaLV0TdxyOL2rVOzr8DXyu11ivjG9XewdD1Qb/M+QnQHTZZMMhLH6LLVnKK/LqRi/illynpwjdpxQvXRRT5FWW2zZxLMinm2OxaRbo1SwFf74DU/2qLt6OK03O8qq25Qbi6fmLGTIwjre8oKnPdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716342132; c=relaxed/simple;
	bh=1NsjmGfLtJx73kUb8hIsMNv/kakBbO7zLkrL7RIESAI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m2M6vzA7sZmZpcWnoeNpuRRH6hSnVDAgEUa+yCynOPn9Rk5bAMy/l5rRMoH/Y5TZEGwGUUewTvgujEZGb9keSy3TAHmk3N+aZ/4umvURawah9vKLMU7MT4n09CC6yKv7Apyb9/uHhqX6+aUgmjjzqhG0OpUfGynDTNTzfLPyoZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=mXRF5/WU; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=jwv90+j6; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=qU3nhvfS reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44LHtJiJ023367;
	Tue, 21 May 2024 18:41:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=1NsjmGfLtJx73kUb8hIsMNv/kakBbO7zLkrL7RIESAI=; b=
	mXRF5/WUd858Q1NDaxTdzL4dbce3DGEUYaSpyofMYVefoWVJIDXDyKHm8dUshhj0
	/m5qsXJh5JUcZk8H/ZFCmREJb5OTlyacXLS8W6BnAgqim1DUDcepO915CJPpIKQZ
	vx52KmnGRw2flkaW9xgqZYWqsDiLgZy0fJb1mX/S5wriBBHi/pTjUZBFWQZE1cCk
	zQXRp4zHekCCb/8/PoPKo9VCAFV46LyKWds75T8E7i8+bqPP/JCtV4Pm93MXwk6v
	POckFKSGD68O1Bd21AfZOAHpXX0+sIhW2WmzN7eEtwJSC+9PZaVr9XQUo9luevuo
	zOy5Q28vzWvFUzLc0lin1w==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3y6ubjp6dx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 May 2024 18:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1716342111; bh=1NsjmGfLtJx73kUb8hIsMNv/kakBbO7zLkrL7RIESAI=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=jwv90+j6JEwVBpvklpqhYY+M2szMot5k3UoA3eFRPCBjNuMyg5qgN14uevowIRe63
	 daisf6aHesV53/g35R0ATSkbLFV3DUgdnsbXWoJEF4ERUNvqIUsd/SnOMKA63d+/Ga
	 Krsr+5I3vmhSjvC1pL13/dXfcobqXzBpxu2kBP+xxbfSsslJ8f8KYl01z3FfyxXEO+
	 der6UhtCw3JND/C+o3ms751uXqYTJTo5eNeeHvjlU2pyuqs0xt7zQMUSFqMs05UTjj
	 YVHVlh/95k1pm4p+dhXh3kLbwE/w3sF1mP6/J5zfoRtF/PbFBXEM1YQtBpfUvhUODc
	 N+lZBpqSSj66w==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 93A3240347;
	Wed, 22 May 2024 01:41:50 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 363BDA005E;
	Wed, 22 May 2024 01:41:49 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=qU3nhvfS;
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 3EB2540357;
	Wed, 22 May 2024 01:41:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TdC0mBuoKQ2G33u96PaUT44uCz+0rb+b4ndhHZEHWMA7YQFcL1Rgx08gr2gzrJ2IJdv1dWceSMRvyoAf7J7LemrFEIOZLBntoHQBmjPOaBLNuUOA8Rp2JgZ7/EhXUtOnCs3cgrvVeX5hvZaoKBbHSyGEmgNzK9LAyQxMY87oJrsNx9NFxHuTlAlzUIuUzthNuaYsRMnJ2FG8UQWmQoexNeibjinHbZczHOj9kZ4170BIIBtoKQzsFkk/T+g9b8WzXQdzqXP/08JrdXnWjRXwfw8yXszKIjEjbyG2gqW4sIRKn/zfeHaltL+gh8sBlmZbEfWZsMj4tuksgtlR7g6LBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NsjmGfLtJx73kUb8hIsMNv/kakBbO7zLkrL7RIESAI=;
 b=KxfrUzyJo6unE21dli90nE0XrbZWkXNFpW1gNqc5EYvCceDKY57bU8FDLTFikZP840rInUG3lgIGZglfN70XLeJ35ji4M91XDlx+aDrkDa+AjtrSjDrlWbN4j99JUt56WxcpD7F3o9PVoJtOhHxaELY7Z1GgF2ibpIGOTp7pBrQpvJxqcV4isyupRxtUVvpJ4cSzueW1u7lB+npy8kt3Ic2v8559IU7RX7BWVEPk2TWYOrm3KqqCrivdwb+isvcOaMz+nkbCQuZJ0F1NSqtd9Zi+wOX3gJIeCh18sZp6M3cRDtKGhoIODMGRqEj4VijVaej/yg++3B+Ffc0QjdJJUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NsjmGfLtJx73kUb8hIsMNv/kakBbO7zLkrL7RIESAI=;
 b=qU3nhvfSKqtzAbTU1575WFg9c+9/pDeT7Z8KnNiKIe4Nynvn/eq0v7SWiKCROnPASuQXyBmRJw4pWs6h0TnYp7QinhgfIgoxW9G3C8GTeZxubUB48eEnFfBO8B6UCNKbOi2pXwKtZjjItHdvWdCjxzA2FeIcFMJiUY04e0Tf4vY=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH7PR12MB6609.namprd12.prod.outlook.com (2603:10b6:510:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Wed, 22 May
 2024 01:41:42 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 01:41:42 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Michael Grzeschik <mgr@pengutronix.de>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Avichal Rakesh <arakesh@google.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jayant Chowdhary <jchowdhary@google.com>,
        "etalvala@google.com" <etalvala@google.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] usb: gadget: uvc: allocate requests based on frame
 interval length and buffersize
Thread-Topic: [PATCH 0/3] usb: gadget: uvc: allocate requests based on frame
 interval length and buffersize
Thread-Index: 
 AQHaisR7p/ka60fKF0m666TF1RlbgLFzcN6AgAGh4ICAAOvGgIAAlmuAgAAznACAHZQygIAGhRmAgAfA2gCAABofAA==
Date: Wed, 22 May 2024 01:41:42 +0000
Message-ID: <20240522014132.xlf7azgq2urfff2d@synopsys.com>
References: <ZiWga5Kqno1ICv97@pengutronix.de>
 <dcad0089-4105-44bc-a2b4-3cfc6f44164b@google.com>
 <ZifEvUi9-E8M4dp8@pengutronix.de>
 <17192e0f-7f18-49ae-96fc-71054d46f74a@google.com>
 <20240424022806.uo73nwpeg63vexiv@synopsys.com>
 <ZkE-O0yJ33T9hWa0@pengutronix.de>
 <20240517014359.p2s44ypl4bix4odm@synopsys.com>
 <Zk03Ys1rA0I5yiZy@pengutronix.de>
In-Reply-To: <Zk03Ys1rA0I5yiZy@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH7PR12MB6609:EE_
x-ms-office365-filtering-correlation-id: 12f7acdd-d186-40a7-efaa-08dc7a005514
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|376005|1800799015|366007|7416005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?cHlsK2h2Ykp6RXp6RlkzQTlyTzQ2Mm1EWmJZMVY5YTdTU3ZyWlhZOW9xTm1D?=
 =?utf-8?B?QldVYWRyUy81RnhqdmtITFdpeGs2N0R4NWh6VjhUZXhhYzVVekF0d0tYVEkr?=
 =?utf-8?B?dm1SWGJKbktYS0pRUW1nUnVidXFiYXdpYmJKS0ptK3AxUjZCMTJrbDdySDU1?=
 =?utf-8?B?RXREZzhsYjVrNmlMUkJkcGp6WElOU0FMTmVUcCsxbW1WU2tZNXR2QTczR1hN?=
 =?utf-8?B?WW5iem14ckR0WjlUcWVPQ0x2K2V2cy93SDE0cWRKcFJpS3JIMHRTaGZOd0U3?=
 =?utf-8?B?M3ZsU0I4dGxHM25ESEFXU3BibVFmOVcwK2diVWduSUdFUTh4cldCSUdzbEJL?=
 =?utf-8?B?eWZ0dm4zVUYwNmpRZUZKNzdEcVAvQTZkaHQxVlFlUFRGcklYcElUR0FQeE90?=
 =?utf-8?B?ZG9XS2gzUW0wbURKbWpuZDkwWXN6SkhoTDRQTTU1Y0NLc1dtZys0ZVhtME9T?=
 =?utf-8?B?cVFheS9IbjMwQ3ovZmNXQ1VlTFM0Nk03QngvZHUySytENmNONTZPTFJCcHpa?=
 =?utf-8?B?TUdkYXE4YVFSL0orVDllTm5NZHBmUmtFU2ZtY3c1SEMxSXhvaFdTVlg3VklF?=
 =?utf-8?B?Tk1FTDJnbWcyOGxyYjFCdVQ1Y2pac2lHY09kZHlmaDZ6SUFnL2FhUUtodERK?=
 =?utf-8?B?MnFERU5VM2VDbGI5R1U0Qmk3OFZlT1ZtaDU2N2NnK090V09wdkc2RW9abmNu?=
 =?utf-8?B?UnRtN0g2UnhiV0NkcEo0VHZxQXhSWGl1NmNSa3hnZXFaVDVDODhmSnozalJi?=
 =?utf-8?B?RW4wa3RZSVliLzV5YkRDZzJQanB1VWVZeW5vNWFESlo4VDJmQVRWd1hhUGUz?=
 =?utf-8?B?UkQ0WUIzeGRicnh0WEdJbTJyTU04WSt6QWFsOWhVclU0N2pKaVhzaW4xbWE0?=
 =?utf-8?B?WWNMTndGK2tDVUlZNEtDb3hIemYwNzJIeGsxRVNNR2ZzMTVJaCtvaDRHWUJp?=
 =?utf-8?B?SjRSc2s1bElISXZ2bDVjN3BRT3JOZU55NCtCbElDVldYRUNUNzlqVThaVkcv?=
 =?utf-8?B?TmNQS1JYaXJ0QVR2cnA4WTdHY1FuWkRzeHJsV0pMbDlsQ1Z4SmJralUxQXpm?=
 =?utf-8?B?UDg0dXI4QzQzcjZOQUR2dXl0YTdIbjdBbzJmR1k5cStwcnBBTW1UQWNwdzhI?=
 =?utf-8?B?T0JOZXdFQTRqaXhsWGxsaTh0TDg5Qno0KzgvcGpxNU03WDRtQXFJeVlXSTJZ?=
 =?utf-8?B?N0dKK1ErOTh6VHo2REZwZFBnb1ZDalhmeEJ4bGh1amVrQTAwci9UV1NwNzE2?=
 =?utf-8?B?YlJxZ0dMcmQ4VU5lRHN4akwzY1g3SGNSL0ZxNm1GYzZVbk1VVEZqbVYvT0g2?=
 =?utf-8?B?WEdXbEt0aXhieGtFUFZvR2hpTTJjTmVwTVNUMDF0SUpyK2ozOHBtZEFJR2lr?=
 =?utf-8?B?UkZ5THlxanZXOWJJMjhUTjladWxURFQ5Y0xWMEdjMGg4S1VRU2tENzllQzl4?=
 =?utf-8?B?bHpqNnJ0LzZWTjdUbSsvTG1qbVNMd09pVGpLY2FJZTIzaWlEektUays5NWJu?=
 =?utf-8?B?Qjhja1ZlMEJZeXVISjJJZzVveVJDTGVoVzV0ZS9QMW1LT3B0QzAwSUVlcG1Z?=
 =?utf-8?B?TU9qbzRJbHZGMU1wc2lNME9ueG4vK3ZXSkoySm9zeTZ4WWljSE53MHJSTWt1?=
 =?utf-8?B?dW5pZDByVEl0Tis3cm9iZ2NiOWkvc0JVc01INStKWFJCcnR1SERpek9yKy9U?=
 =?utf-8?B?Mnh4dm9Iam9VK01OY281SGZVNm9PajVqTjI5TkxFZE5RbC90QnhMYnpOYUZH?=
 =?utf-8?B?VURwZWJQbjZZYVoyeGpsQkRkaXYvZnpnRmdJaFd0WG5lQ2p0MjBMSlRybkhr?=
 =?utf-8?B?NEEyV1NRdkY2K09oblBDQT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?S1p6cXZ0RUtpalFxRUhUQkxZVUVzNTlPT1AraFI3ZThvcUZpZUEvODRIYnpt?=
 =?utf-8?B?ZzhhdXE5eTNvWENZMkdueG12aWdHcWdXdjV2UGlpN29oZElSMFZZUjRET0Yv?=
 =?utf-8?B?N3Mvekdmb0JuTGltcVAzSEVwMzBtK0VKMGRSem1LSk51TmNZbkV0Nk1JQ2dX?=
 =?utf-8?B?VVl3aktHNjdDNWNVV3h5cjYvMDNjTXJBVGdhSlR3VSt0U25ldFhtNjd1YVpV?=
 =?utf-8?B?czlMbTdnTWhjdlBTSjc3RUdWWWNpeVdsWFdaVmpCV2dBODRiSHdzTFBobDNY?=
 =?utf-8?B?YzhNbFNSWDJDWm5hNittdXJxUmRXR0tZL3VWUndaNW9DMU9zOVlIcmg0L1pJ?=
 =?utf-8?B?MnE2UHdha1laK0JGQm14QXpnVW55aG1BUWlOZ1g1dkUyS1ZqR25RYlBoWjhW?=
 =?utf-8?B?Z1NVZTJsRWtJL3hMaVJ6UytPU3VXdGw1dHpWUk92SVYxWDZpYTZzb3FUV0hq?=
 =?utf-8?B?anFRSGRBeFJSMktUek1mdVl5R0o2SFlheGs4WmwrY3lUZElxb0t4OG9xekdI?=
 =?utf-8?B?cnFzNGdTZzhjZ2kvSHA5TlM3R1pWRk5ONitad2ZCZWU0VHlMSms0d0s2Sndx?=
 =?utf-8?B?aVYvUTFhbnR3MWwvdGlkRzRoTnJTSVpaNER4NDgwWlF6eXFWc1VlUE9DNU9R?=
 =?utf-8?B?L0QrcURvekpseHFZRk0waWVyUzAyKy80THIrSDlpWEZCY21qK2x2MXB2U1c5?=
 =?utf-8?B?YlhCdHFoUTZyRkkrNUVYZStncnlVNGloNDF0N2U2UzRwV3VsRTh3N05wY202?=
 =?utf-8?B?TDh6RytIa0NRYysxOURNZm9aNVRqcnUwTE91UytrZU1RclRDNWZsVmkvdnF6?=
 =?utf-8?B?aHBFVVRuYUNzRVdQOHdoYW9BdkREbGc5Y05qcFJjbmRRbjBhSnhjaE5CdSsx?=
 =?utf-8?B?SGVYNkpYbTJJVEhXanQreGV5cDRqTE9yelVhYXJKWExQb3BibjRYaGkvUy8x?=
 =?utf-8?B?c3B2bkJCQzE5NVhyNnh2M2ZTNDlsaVZkUmhFVmdGNHFROEpTVm5JUWNpK1dy?=
 =?utf-8?B?Y2pFNkE0SGRLUVMxajRnUDN2RkRIVnpZQUsrM1g5ZHFTZHpMOEgyektlM3dw?=
 =?utf-8?B?QzRKOWcvZGtqcE5laGtJWjRIOFdUUlNMRThNZkhRSUxpK09kczBZeEJzYi81?=
 =?utf-8?B?T0VsVitZZGVmNHhTWDIxWEFZTHNmTDJ1Q1hhVWNITE9vRzk2eUFPb2lyK2l1?=
 =?utf-8?B?RzJIai9PTW5WbFVRcTdwV0pWWnNXWnI0TzY3YkhoNGlwSjJSQzNsZWhiK2p2?=
 =?utf-8?B?ZlhGRnlTZ1FLOFU3NHBwWjZoWFJ6MWpTQi9hQTRQS1oyeURhV0pFczlyYzZX?=
 =?utf-8?B?Q0VuZCtRUnZTY21RZ1Z4Q0Rwb0lKYmROZncwR1J6S2duRTZ1UUlsTGJ5SEEx?=
 =?utf-8?B?ejBOL3M1ckg1YXdYWWxRbENrUXB4Y0hsajFXcDVHc21kQmdPOUUxNmlLUkxn?=
 =?utf-8?B?bEFRWnFtdi9zckpHK1VPY1VLTXU1WnFxS0htSDk2WG9IUjVHeGhmNFlOZlJ3?=
 =?utf-8?B?a0FJdHpuSjVKMzNkYnRZMnRlUVJDTXRia0xuMk5ndHBEQTJBNWhSak5pNDlN?=
 =?utf-8?B?T2tNSkM0U2pQdVowMU5jSTVFeHhiVHhOc3JoV1hOdjEzWTBTeVpGaWY2Wk82?=
 =?utf-8?B?dFJ1Q3BtWGljMW02QUdsdTM3Kys2N0FabDZEZ0NXVkhML1NaaVRTOHZsRlhD?=
 =?utf-8?B?WXMrc2l0M2lBOFMvZ01tWHczSm9LM2FmclVMcnRsYkJpRmtzTWs0UTVBZG9Z?=
 =?utf-8?B?SHJ1TGFzcldLczh5UmtCK1N3d2FTMERPQ1hXRW9yOVBqVUlCZ0FFOWxVYmlq?=
 =?utf-8?B?YzhNVmdub0FZdndkdldqazNxV1hWTFQ4djFrVFZRUG5rSGRFb3ZPd1hZdnBr?=
 =?utf-8?B?UmJBbkdZWjZmOEFXbDdCaERUdGpnZm84Zkp4eHE1blQ5WlpzUGhOVnNqeW5D?=
 =?utf-8?B?bUdVVU1sMEgzOGIxWkcxeUZrZmVlZFlqZGpHbnN3enRjTkMrVEVocmh0ZjM5?=
 =?utf-8?B?aDUwclNYbk9RWWp6STMzVFpTeStkalQ3dllyZVhkKy9WVHlWaEZKVDg2Qjg1?=
 =?utf-8?B?WG1pbFBWK0Zlajk0UUZHOFh3V2s4ZG9jR2doc04xQWJJbkNXUFZGQ1JETUZl?=
 =?utf-8?Q?hxgNAbm/124MZ5NURIjzSPBW2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0279F96962CCB04E8D9DCACE5A66E4FD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vfTDgRHYVUEV4VoqR5EYUD+TkkxDsjgoBhO+0fMpN4seJ25KEy7Hellqo2HCxsXgA1LYxg1BFU5rr4EUHPHSM35yUgYZM7V20dm7Kc+B/tvpxmLmKTuk16Htbole+FmyC7wh8wTCTwFHieNuIHwtHDHXjNDv4Y0c8QNumULMlcPeM8oAaCTHg0pRDDSxWEkkXLo++50tFN8OpDjhyRB691nsgD3G0OXcunUzBb+xmlF7kCEWqEymX79kpljJw1bcRrBjzm6OMajCLs2lHbIWwcT8O9kKcy/fePOiTEirzBV89rPejLvFGDXP5ByuXaV9ZSCgxvsjXaqlWxqnAkEUjVa4cXFGsonZ4qchGXtSkD33cCDX3s3RD9lVxhai4zeEgzEoxRMuCjaIpFPS4VUALi8gXrfeKYKRxCFTkvwZlN+P10KrSusZw+qZ54ES7jOJgCRBUFLGi+eAXNM+W8fiyqdKDvPplR4KZ4IDT7zW4JQ0UDCB5nZhu889w601Y7DaTfVjMrP+jmqxmZ1LJ9AjDWYF6nnwUOPiwiNohFfI0iBvwRIRicuQNieihywySklLExHaV0uNZoSVZHKp3LkjNcx0llijrOW47KauK6J32kTLQOjwy9ulHLoTCa+al6h3+WWyhb3AncICDhkgXph2gw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f7acdd-d186-40a7-efaa-08dc7a005514
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 01:41:42.5575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qW0Q7NJs8nECfGtAJLGjKgkWi+stAhVCLpw5Rd3Ttc/AHcbxSxeDuvCD0LIzfYHyEPz02EOYXcEdKKuA8XYPZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6609
X-Proofpoint-ORIG-GUID: otSBOpneSkLlnrBONg5yUO_yWuClvhuL
X-Proofpoint-GUID: otSBOpneSkLlnrBONg5yUO_yWuClvhuL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_15,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405010000 definitions=main-2405220010

T24gV2VkLCBNYXkgMjIsIDIwMjQsIE1pY2hhZWwgR3J6ZXNjaGlrIHdyb3RlOg0KPiBPbiBGcmks
IE1heSAxNywgMjAyNCBhdCAwMTo0NDowNUFNICswMDAwLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+
ID4gT24gTW9uLCBNYXkgMTMsIDIwMjQsIE1pY2hhZWwgR3J6ZXNjaGlrIHdyb3RlOg0KPiA+ID4g
DQo+ID4gPiBJIHRoaW5rIHdlIGhhdmUgdG8gZGlzY3VzcyB3aGF0IGlzIG1lbnQgYnkgcmVzeW5j
aHJvbml6YXRpb24gaGVyZS4gSWYNCj4gPiA+IHRoZSB0cmIgcmluZyBidWZmZXIgZGlkIHJ1biBk
cnkgYW5kIHRoZSBzb2Z0d2FyZSBpcyBhd2FyZSBvZiB0aGlzDQo+ID4gPiAoZWxlbW50IGluIHRo
ZSBzdGFydGVkIGFuZCBwcmVwYXJlZCBsaXN0KSB0aGVuIHRoZSBpbnRlcnJ1cHQgaGFuZGxlcg0K
PiA+ID4gYWxyZWFkeSBpcyBjYWxsaW5nIEVuZCBTdHJlYW0gQ29tbWFuZC4NCj4gPiANCj4gPiBU
aGUgZHJpdmVyIG9ubHkgYXdhcmUgb2YgdGhpcyB3aGVuIHRoZSBjb250cm9sbGVyIHRlbGxzIGl0
LCB3aGljaCBtYXkgYmUNCj4gPiBhbHJlYWR5IHRvbyBsYXRlLg0KPiANCj4gSW4gb3VyIHNwZWNp
YWwgY2FzZSB0aGVyZSBzaG91bGQgbm90IGJlIGFueSB0b28gbGF0ZSBhbnkgbW9yZS4gU2luY2Ug
d2UNCj4gZW5zdXJlIHRoYXQgYWxsIHJlcXVlc3RzIHdpbGwgYmUgZW5xdWV1ZWQgZm9yIG9uZSB0
cmFuc2ZlciAod2hpY2ggd2lsbA0KPiByZXByZXNlbnQgb25lIGZyYW1lKSBpbiB0aW1lIGFuZCB3
ZSBhcmUgbm90IGRlcGVuZGVudCBvbiB0aGUgY29tcGxldGUNCj4gaGFuZGxlciBmb3Igbm90aGlu
ZyBlbHNlIHRoYW4gdGVsbGluZyB0aGUgdXZjIGRyaXZlciB0aGF0IHRoZSBsYXN0DQo+IHJlcXVl
c3QgY2FtZSBiYWNrIG9yIGlmIHRoZXJlIHdhcyBzb21lIGVycm9yIGluIHRoZSBjdXJyZW50IGFj
dGl2ZQ0KPiBmcmFtZS4NCj4gDQo+IEFzIGFscmVhZHkgc3RhdGVkIHdlIGFsc28gaGF2ZSB0byB3
YWl0IHdpdGggZW5xdWV1ZWluZyB0aGUgbmV4dCBmcmFtZQ0KPiB0byB0aGUgaGFyZHdhcmUgYW5k
IG9ubHkgYXJlIGFsbG93ZWQgdG8gZW5xdWV1ZSBvbmUgZnJhbWUgYXQgYSB0aW1lLg0KPiBPdGhl
cndpc2UgaXQgaXMgbm90IHBvc3NpYmxlIHRvIHRlbGwgdGhlIGhvc3QgaWYgdGhlIGZyYW1lIHdh
cyBicm9rZW4gb3INCj4gbm90Lg0KPiANCj4gSSBoYXZlIHRoZSBmb2xsb3dpbmcgc2NoZW1lIGlu
IG15IG1pbmQuIEl0IGlzIHNpbXBsaWZpZWQgdG8gdGFrZSBmcmFtZXMNCj4gb2Ygb25seSA0IHJl
cXVlc3RzIGludG8gYWNjb3VudC4gKD44MCBjaGFycyB3YXJuaW5nKQ0KPiANCj4gDQo+IGZyYW1l
aW50ZXJ2YWw6ICAgICAgICAgICAgICAgIHwgICAgICAgMTI1IHVzICAgICAgIHwgICAgICAgMTI1
IHVzICAgICAgIHwgICAgICAgMTI1IHVzICAgICAgIHwgICAgICAgMTI1IHVzICAgICAgIHwgICAg
ICAgMTI1IHVzICAgICAgIHwgICAgICAgMTI1IHVzICAgICAgIHwgICAgICAgMTI1IHVzICAgICAg
IHwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAg
fCAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAg
ICAgICAgfCAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgfCAgICAgICAg
ICAgICAgICAgICAgfA0KPiBwdW1wIHRocmVhZDogICBxdWV1ZSAgICAgICAgICB8cnFBMSBycUEy
IHJxQTMgcnFBNCd8ICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICB8ICAg
ICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICB8cnFCMCBycUIxIHJxQjIgcnFC
MyB8cnFCNCcgICAgICAgICAgICAgICB8DQo+IGlycSAgdGhyZWFkOiAgIGNvbXBsZXRlICAgICAg
IHwgICAgICAgICAgICAgICAgICAgIHxycUExICAgICAgICAgICAgICAgIHxycUEyICAgICAgICAg
ICAgICAgIHxycUEzICAgICAgICAgICAgICAgIHxycUE0JyAgICAgICAgICAgICAgIHwgICAgICAg
ICAgICAgICAgICAgIHxycUIwICAgICAgICAgICAgICAgIHwgcnFCMQ0KPiBxYnVmIHRocmVhZDog
ICBlbmNvZGUgICAgICAgICB8cnFCMSBycUIyIHJxQjMgcnFCNCd8ICAgICAgICAgICAgICAgICAg
ICB8ICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAg
ICAgICAgICB8cnFBMSBycUEyIHJxQTMgcnFBNCd8ICAgICAgICAgICAgICAgICAgICB8DQo+IA0K
PiBkd2MzIHRocmVhZDogICBIYXJkd2FyZSAgICAgICAgICAgICAgICAgICAgICAgICAgICA8IFN0
YXJ0IFRyYW5zZmVyICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIEVuZCBUcmFuc2ZlciA+ICAgICAgICAgICAgICAgICAgICA8IFN0YXJ0IFRyYW5z
ZmVyICAgICAgLi4uLg0KPiANCj4gbGVnZW5kOg0KPiAtIHJxJyAgOiBsYXN0IHJlcXVlc3Qgb2Yg
YSBmcmFtZQ0KPiAtIHJxQjAgOiBmaXJzdCByZXF1ZXN0IG9mIHRoZSBuZXh0IHRyYW5zZmVyIHdp
dGggbm8gcGF5bG9hZCBidXQgdGhlIGhlYWRlciBvbmx5DQo+ICAgICAgICAgIHRlbGxpbmcgdGhl
IGhvc3QgdGhhdCB0aGUgbGFzdCBmcmFtZSB3YXMgb2svYnJva2VuDQo+IA0KPiBhc3N1bXB0aW9u
Og0KPiANCj4gLSBwdW1wIHRocmVhZCBpcyBuZXZlciBpbnRlcnJ1cHRlZCBieSBhIGtlcm5lbCB0
aHJlYWQgYnV0IG9ubHkgYnkgc29tZSBzaG9ydCBydW5uaW5nIGlycQ0KPiAtIGlmIG9uZSByZXF1
ZXN0IGNvbWVzIGJhY2sgd2l0aCAtRVhERVYgdGhlIHJlc3Qgb2YgdGhlIGVucXVldWVkIHJlcXVl
c3RzIHNob3VsZCBiZSBmbHVzaGVkDQo+IA0KPiBJbiB0aGUgbm9faW50ZXJydXB0IGNhc2Ugd2Ug
d291bGQgYWxzbyBvbmx5IGdlbmVyYXRlIHRoZSBpbnRlcnJ1cHQgZm9yDQo+IHRoZSBsYXN0IHJl
cXVlc3QgYW5kIGdpdmViYWNrIGFsbCBmb3VyIHJlcXVlc3RzIGluIHRoZSBsYXN0IGludGVydmFs
Lg0KPiBUaGlzIHNob3VsZCBzdGlsbCB3b3JrIGZpbmUuDQo+IA0KPiBXZSBhbHNvIG9ubHkgc3Rh
cnQgc3RyZWFtaW5nIHdoZW4gb25lIGZyYW1lIGlzIHRvdGFsbHkgYXZhaWxhYmxlIHRvIGJlDQo+
IGVucXVldWVkIGluIG9uZSBydW4uIFNvIGluIGNhc2UgZnJhbWVzIHdpdGggcnFBIGFuZCBycUIg
Ym90aCBkaWQgY29tZSBiYWNrDQo+IHdpdGggZXJyb3JzIHRoZSBzdGFydCBvZiB0aGUgbmV4dCBm
cmFtZSB3aWxsIG9ubHkgYmVnaW4gYWZ0ZXIgdGhlIG5leHQNCj4gZnJhbWUgd2FzIGNvbXBsZXRl
bHkgYW5kIGZ1bGx5IGVuY29kZWQuDQoNClllcy4gVGhpcyBpcyBiZXR0ZXIuDQoNCj4gDQo+ID4g
PiBXaGVuIHRoZSBzdHJlYW0gaXMgc3RvcHBlZCwgd2hhdCBpbXBsaWNhdGlvbnMgZG9lcyB0aGlz
IGhhdmUgb24gdGhlIGJ1cz8NCj4gPiA+IA0KPiA+ID4gV2hlbiB0aGUgRW5kcG9pbnQgaXMgZW5h
YmxlZCwgd2lsbCB0aGUgaGFyZHdhcmUgdGhlbiBzZW5kIHplcm8tbGVuZ3RoDQo+ID4gPiByZXF1
ZXN0cyBvbiBpdHMgb3duPw0KPiA+IA0KPiA+IEZvciBpc29jIGVuZHBvaW50IElOLCB5ZXMuIElm
IHRoZSBob3N0IHJlcXVlc3RzIGZvciBpc29jIGRhdGEgSU4gd2hpbGUNCj4gPiBubyBUUkIgaXMg
cHJlcGFyZWQsIHRoZW4gdGhlIGNvbnRyb2xsZXIgd2lsbCBhdXRvbWF0aWNhbGx5IHNlbmQgMC1s
ZW5ndGgNCj4gPiBwYWNrZXQgcmVzcG9uZC4NCj4gDQo+IFBlcmZlY3QhIFRoaXMgd2lsbCBoZWxw
IGEgbG90IGFuZCB3aWxsIG1ha2UgYWN0aXZlIHF1ZXVlaW5nIG9mIG93bg0KPiB6ZXJvLWxlbmd0
aCByZXF1ZXN0cyBydW4gdW5uZWNlc3NhcnkuDQoNClllcywgaWYgd2UgcmVseSBvbiB0aGUgY3Vy
cmVudCBzdGFydC9zdG9wIGlzb2MgdHJhbnNmZXIgc2NoZW1lIGZvciBVVkMsDQp0aGVuIHRoaXMg
d2lsbCB3b3JrLg0KDQo+IA0KPiA+ID4gV2l0aCB0aGUgbmV4dCBlcF9xdWV1ZSB3ZSBzdGFydCBh
bm90aGVyIHN0cmVhbSBhbmQgd2hlbiB3ZSBrZWVwIHVwIHdpdGgNCj4gPiA+IHRoaXMgc3RyZWFt
IHRoZXJlIGlzIG5vIHVuZGVycnVucywgcmlnaHQ/DQo+ID4gPiANCj4gPiA+IEkgcGljdHVyZSB0
aGlzIHNjZW5hcmlvIGluIG15IG1pbmQ6DQo+ID4gPiANCj4gPiA+IHRocmVhZCAxOiB1dmMtPnF1
ZXVlX2J1ZiBpcyBjYWxsZWQ6DQo+ID4gPiAgIC0gd2UgZW5jb2RlIHRoZSBmcmFtZSBidWZmZXIg
ZGF0YSBpbnRvIGFsbCBhdmFpbGFibGUgcmVxdWVzdHMNCj4gPiA+ICAgICBhbmQgcHV0IHRoZW0g
aW50byB0aGUgcGVyIHV2Y19idWZmZXIgcGVycGFyZWQgbGlzdA0KPiA+ID4gICAgIChhcyB3ZSBw
cmVjYWxjdWxhdGVkIHRoZSBhbW91bnQgb2YgcmVxdWVzdHMgcHJvcGVybHkgdG8gdGhlIGV4cGVj
dGVkDQo+ID4gPiAgICAgIGZyYW1lIGR1cmF0aW9uIGFuZCBidWZmZXIgc2l6ZSB0aGVyZSB3aWxs
IGJlIGVub3VnaCByZXF1ZXN0cw0KPiA+ID4gICAgICBhdmFpbGFibGUpDQo+ID4gPiAgIC0gd2Fr
ZSB1cCB0aGUgcHVtcCB0aHJlYWQNCj4gPiA+IA0KPiA+ID4gdGhyZWFkIDI6IHB1bXBfd29ya2Vy
IGlzIHRyaWdnZXJlZA0KPiA+ID4gICAtIHRha2UgYWxsIHJlcXVlc3RzIGZyb20gdGhlIHByZXBh
cmVkIGF2YWlsYWJsZSBidWZmZXIgYW5kIGVucXVldWUgdGhlbQ0KPiA+ID4gICAgIGludG8gdGhl
IGhhcmR3YXJlDQo+ID4gPiAgICAgKFRoZSBwdW1wIHdvcmtlciBpcyBydW5uaW5nIHdpdGggd2hp
bGUoMSkgd2hpbGUgaXQgZmluZHMgcmVxdWVzdHMgaW4NCj4gPiA+ICAgICAgdGhlIHBlciBidWZm
ZXIgcHJlcGFyZWQgbGlzdCkgYW5kIHRoZXJlZm9yIHdpbGwgaGF2ZSBhIGhpZ2ggY2hhbmNlDQo+
ID4gPiAgICAgIHRvIGZpbmlzaCB0aGUgcHVtcGluZyBmb3Igb25lIGNvbXBsZXRlIGZyYW1lLg0K
PiA+ID4gICAtIGNoZWNrIGZvciBhbnkgZXJyb3JzIHJlcG9ydGVkIGZyb20gdGhlIGNvbXBsZXRl
IGhhbmRsZXJzDQo+ID4gPiAgICAgLSBvbiBlcnJvcg0KPiA+ID4gICAgICAgLSBzdG9wIGVucXVl
aW5nIG5ldyByZXF1ZXN0cyBmcm9tIGN1cnJlbnQgZnJhbWUNCj4gPiA+ICAgICAgIC0gd2FpdCBm
b3IgdGhlIGxhc3QgcmVxdWVzdCBmcm9tIGVycm9ybm91cyBmcmFtZSBoYXMgcmV0dXJuZWQNCj4g
PiA+ICAgLSBvbmx5IHN0YXJ0IHB1bXBpbmcgbmV3IHJlcXVlc3RzIGZyb20gdGhlIG5leHQgYnVm
ZmVyIHdoZW4gdGhlIGxhc3QNCj4gPiA+ICAgICByZXF1ZXN0IGZyb20gdGhlIGFjdGl2ZSBmcmFt
ZSBoYXMgZmluaXNoZWQNCj4gPiA+ICAgLSBJbiB0aGUgYmVnaW5uaW5nIG9mIHRoZSBuZXh0IGZy
YW1lIHNlbmQgb25lIGV4dHJhIHJlcXVlc3Qgd2l0aA0KPiA+ID4gICAgIEVPRi9FUlIgdGFnIHNv
IHRoZSBob3N0IGtub3dzIHRoYXQgdGhlIGxhc3Qgb25lIHdhcyBvayBvciBub3QuDQo+ID4gPiAN
Cj4gPiA+IHRocmVhZCAzOiBjb21wbGV0ZSBoYW5kbGVyIChpbnRlcnJ1cHQpDQo+ID4gPiAgIC0g
Z2l2ZSBiYWNrIHRoZSByZXF1ZXN0cyBpbnRvIHRoZSBlbXB0eV9saXN0DQo+ID4gPiAgIC0gcmVw
b3J0IEVYREVWIGFuZCBlcnJvcnMNCj4gPiA+ICAgLSB3YWtlIHVwIHRoZSBwdW1wIHRocmVhZA0K
PiA+ID4gDQo+ID4gPiBXaXRoIHRoaXMgbWV0aG9kIHdlIHdpbGwgY29udGlub3VzbHkgZHJhaW4g
dGhlIGh3IHRyYiBzdHJlYW0gb2YgdGhlIGR3YzMNCj4gPiA+IGNvbnRyb2xsZXIgcGVyIGZyYW1l
IGFuZCB0aGVyZWZvciB3aWxsIG5vdCBzaG9vdCBpbnRvIG9uZSB3aW5kb3cgd2hlcmUNCj4gPiA+
IHRoZSBjdXJyZW50IHN0cmVhbSBjb3VsZCBiZSBtaXNzZWQuIFdpdGggdGhlIGRhdGEgc3ByZWFk
aW5nIG92ZXIgdGhlDQo+ID4gPiBtYW55IHJlcXVlc3RzIHdlIGFsc28gYXZvaWQgdGhlIG1pc3Nl
ZCByZXF1ZXN0cyB3aGVuIHRoZSBETUEgd2FzIHRvDQo+ID4gPiBzbG93Lg0KPiA+ID4gDQo+ID4g
DQo+ID4gVGhpcyBzb3VuZHMgZ29vZC4NCj4gPiANCj4gPiBBcyBsb25nIGFzIHdlIGNhbiBtYWlu
dGFpbiBtb3JlIHRoYW4gWCBudW1iZXIgb2YgcmVxdWVzdHMgZW5xdWV1ZWQgdG8NCj4gPiBhY2Nv
bW9kYXRlIGZvciB0aGUgd29yc3QgbGF0ZW5jeSwgdGhlbiB3ZSBjYW4gYXZvaWQgdW5kZXJydW4u
IFRoZSBkcml2ZXINCj4gPiBzaG91bGQgbW9uaXRvciBob3cgbWFueSByZXF1ZXN0cyBhcmUgZW5x
dWV1ZWQgYW5kIGhvcGVmdWxseSBjYW4ga2VlcCB1cA0KPiA+IHRoZSBxdWV1ZSB3aXRoIHplcm8t
bGVuZ3RoIHJlcXVlc3RzLg0KPiANCj4gRXhjZXB0IEkgdG90YWxseSBtaXN1bmRlcnN0b29kIHNv
bWV0aGluZyBvciBkaWQgb3ZlcnNpbXBsaWZ5IHRvIG11Y2gsDQo+IHRoZSBhYm92ZSBleHBsYW5h
dGlvbiBzaG91bGQgcnVuIHRoaXMgdW5uZWNlc3NhcnkuDQo+IA0KPiBBbHRob3VnaCB3ZSBhcmUg
YWJsZSB0byB0cmFjayB0aGUgYW1vdW50IG9mIGVucXVldWVkIHJlcXVlc3RzIGluIHRoZSB1ZGMN
Cj4gZHJpdmVyIGFuZCBjb21wYXJlIHRoYXQgd2l0aCB0aGUgYW1vdW50IG9mIGNvbXBsZXRlZCBy
ZXF1ZXN0cy4NCj4gDQo+IEFsc28gd2UgaGF2ZSB0aGUgdXNiX2dhZGdldF9mcmFtZV9udW1iZXIg
Y2FsbGJhY2sgdG8gdGhlIHVkYyBjb250cm9sbGVyDQo+IHRvIGFzayBpbiB3aGljaCBmcmFtZSBp
dCBpcyBvcGVyYXRpbmcgYXQgdGhlIG1vbWVudC4gVGhpcyB3YXkgd2Ugd291bGQNCj4gYmUgYWJs
ZSB0byBjYWxjdWxhdGUgbm90IHRvIGVucXVldWUgcmVxdWVzdHMgaW50byBhIHRyYW5zZmVyIHRo
YXQgZGlkDQo+IG5vdCBjb21lIGJhY2sgeWV0IGNvbXBsZXRlbHkgYnV0IHdvdWxkIHJ1biBpbnRv
IG1pc3NlZCB0cmFuc2ZlcnMuDQo+IA0KDQpJIHdvdWxkIG5vdCBkZXBlbmQgdG9vIG11Y2ggb24g
dXNiX2dhZGdldF9mcmFtZV9udW1iZXIoKS4gVGhlcmUncyBub3QNCnJlYWxseSBhIGhhcmQgcmVx
dWlyZW1lbnQgZm9yIHRoZSBvdXRwdXQuIEl0J3MgY29udHJvbGxlciBzcGVjaWZpYy4gRm9yDQpk
d2MzIGNvbnRyb2xsZXIsIGlmIG9wZXJhdGUgaW4gaGlnaHNwZWVkIG9yIGhpZ2hlciwgaXQgcmV0
dXJucw0KbWljcm9mcmFtZSBudW1iZXIuIEZvciBmdWxsc3BlZWQsIGl0IHJldHVybnMgZnJhbWUg
bnVtYmVyLg0KDQpBcyB5b3Ugbm90ZWQsIGlmIHlvdSBjYW4gd2FpdCBhbmQgcXVldWUgYWxsIHRo
ZSByZXF1ZXN0cyBvZiBhIHZpZGVvDQpmcmFtZSBhdCBvbmNlLCB0aGVuIHRoaXMgd2lsbCB3b3Jr
IGFsc28uDQoNClRoYW5rcywNClRoaW5o

