Return-Path: <linux-kernel+bounces-225481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9F3913112
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 02:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 397E51F22FA5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 00:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E887FD;
	Sat, 22 Jun 2024 00:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="KOU7DCFh";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="fS9GQlAx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="QsZnSWRS"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2631B79C0;
	Sat, 22 Jun 2024 00:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719014758; cv=fail; b=KERoCiM3hkYGNpcrL7sG9sSmcdFgWnC3xbkMPi7sAkyojPXGw48osQQ4pVczg6ezMPCO+VN+Q4i2BZe7nxQDdpAVo8ERxe1cMVL/o6S630X+sTTSETZ43GDPshr/Je22BXb8U6dH8JQ7RVKvmNfxwCPl6Ug4fdsF/Qew76ibEfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719014758; c=relaxed/simple;
	bh=xnaghqyDYOHfAKJ3qS1SjED34HIRhJdtTWuuimEs01s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fgxF5j8BLRRLDtVWPlayXhujlfw7IpnBWSMHDSxOMDkUsA6bLcOi8+qJitj/8Ijc/4wV/Ep7KrwYGRHdcyDpbB1vilU1a2lI2BCzrxEejJl8atFko7+6OA0TqenXS1yPOq/KcUYafdLx39nlLiiborjg0exZSZWKW2AlwPIt3Kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=KOU7DCFh; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=fS9GQlAx; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=QsZnSWRS reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LHjLOM015991;
	Fri, 21 Jun 2024 17:05:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=xnaghqyDYOHfAKJ3qS1SjED34HIRhJdtTWuuimEs01s=; b=
	KOU7DCFhY5wUFkzAShu1GQR+CwTvA2IKOZLWxVZ+SUDrcTaSEJzmycm1apsQH0iX
	SxsCWLFZ9tNcX7+c24laK4ByvXZzldLg4KHX27ZIkajHZaVSKs5rfjCU7s+rrQ77
	EumPZblVwJaQFB9HrX6t03TIPlYr1n0jfDDpbePKaWAdswBpbsCQHdvnPhTAFOC3
	F/QD2Iuh1eFhHRfmU1s1wD6ew1mNHrpWNkLVkF1vYjAFvz+iyYVGf9UN1teVUnWn
	TTt0VXAJf63hLRibKxsdrSxc7IKr58JRt1fl2VBlimpmj+OMKmKFyqyywL2UQ+44
	wnawJp/0luLETzZwBxfUBQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3yvrk1pfnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 17:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1719014738; bh=xnaghqyDYOHfAKJ3qS1SjED34HIRhJdtTWuuimEs01s=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=fS9GQlAxSRrPUwIAwtl6jxA9hxqLchkMwCdIuMLFiDsxaIJrs0+9+FfPLK3+UKGA9
	 pfsceXTXEdM0QNrWKPckxbsALG0pHTGq0lgKp8PnhBWxRLhiJ140larIlw8I5cD44p
	 o5TtS+nJvvfQ+mJok5XO8XgXrdRT4dLGBzZmgQHOxvzN2Y40LQa+ay3dozATshz3OP
	 6epH9ofmm0rkmyqVrkHjjYXhBh8Y+Xuacw1tUm9l70iw9ciAULUZbvJ5jzxqD5FoA7
	 bC0x9eJ0jviLdEgvd16fNkE+Z7oXOCPnBMosC46410xOtRLHTa/ZoHchWxVJFTNN18
	 VQUuY8mljXAWQ==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D2DE74035A;
	Sat, 22 Jun 2024 00:05:37 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 6658DA0070;
	Sat, 22 Jun 2024 00:05:37 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=QsZnSWRS;
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 83DE94084A;
	Sat, 22 Jun 2024 00:05:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YR0Bpeh3dPQPZQojO3vme+uLQhYI4OvTMp9ZfFgyUVVC6E2zyeTWBJrPm7cN8G/22CpIGuG7zG4jm3xjU0N/PUTNO9tUIn7zXhDd3NME1pdvWo/yyEknMOxZhjpjxxlF7U9JNpih4BJymDA9cS/8ck6fps6bIK93z8ZoFyw5mhMlsAmG91kMOa0hrRExS8qaDiYRKmeUxxe5wb01J9fyjyaoePzl7t8l6nSGH6cCAZtkr9pDCVcJFRWBF2LIZ9U72c50BKII6Xx5RrjaXxSaI97GakIdaz+NZiqGpwfZGoQRqI6oWEEAfGZf4wVDglzMjePCq1iPnzhHcqlRXLuwug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnaghqyDYOHfAKJ3qS1SjED34HIRhJdtTWuuimEs01s=;
 b=eBpwb7nP8DTHQ2EBgsohHkQICyek7I8pi28DnYuJctJRt6RstHB9Ngi692Pm0ymSeeUa6cv7haQBf9Fex3nF3hEaqfzBDuS6cVtzqnDdpxJjMeqARXZslDiqCqQd4Hav9TqtzafbV3vocoH4TiAEwg3IwYtNHO2vRJjAmEmxWOjB8CO1N9Y+8hQf5FJaw1mvY4R1n5VvIIyzSLlsdnSDiww7xfCBoqmKiqt7+pxTQADuoUIkXgADrJO+lrTI4E6I94bbVbq5iKGIL0vlilby23GqHj3h0AkrnZulv8Amc8Uin1GxErB5QopL7AbeT3E06GB9l+Wn6VIP9wC37yg7fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnaghqyDYOHfAKJ3qS1SjED34HIRhJdtTWuuimEs01s=;
 b=QsZnSWRSvxg7j59U5jGMsV3r6twDAyy2CyFvV9X1aPPAvZqAz5QqHFMwcl+JGVxNVN3fXODAMwbZtPEkgJIDLGjXBynpc73sIbr43qMwvgx/KQ5GulAY0oLY0B7esABN651LpHRBN1ZUdyNfjTx9gYx+2Y79g5++/SShjNRQl6o=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by IA0PR12MB7749.namprd12.prod.outlook.com (2603:10b6:208:432::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Sat, 22 Jun
 2024 00:05:32 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.7698.020; Sat, 22 Jun 2024
 00:05:32 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: joswang <joswang1221@gmail.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        joswang <joswang@lenovo.com>
Subject: Re: [PATCH v2, 2/3] usb: dwc3: core: add p3p2tranok quirk
Thread-Topic: [PATCH v2, 2/3] usb: dwc3: core: add p3p2tranok quirk
Thread-Index: AQHatbYvEKCjzMC7MUi9d+7VCvXe+bG2uVyAgBhalICAA/BqAA==
Date: Sat, 22 Jun 2024 00:05:32 +0000
Message-ID: <20240622000528.3keexfbetetkrxpy@synopsys.com>
References: <20240601092646.52139-1-joswang1221@gmail.com>
 <20240603130126.25758-1-joswang1221@gmail.com>
 <20240604000147.2xxkkp7efjsbr3i5@synopsys.com>
 <CAMtoTm0S2WSO6VxK79DkTs+1aq5xBYBMRsPXWAFuWo4DoymUEw@mail.gmail.com>
In-Reply-To: 
 <CAMtoTm0S2WSO6VxK79DkTs+1aq5xBYBMRsPXWAFuWo4DoymUEw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|IA0PR12MB7749:EE_
x-ms-office365-filtering-correlation-id: 5f21f0ea-1011-4a3f-20a7-08dc924f086a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230037|366013|7416011|1800799021|376011|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?dkZQYzc4RVNQT1lmM0xzdk9iY3dKMU02SlhNQVl2YnFLbW0yeklUTTFYR0hV?=
 =?utf-8?B?cXd0MXdhcFBDSlcrZWdzQnFyTHNhMmJVYm5BYXl4SjlIMTloLzJLaVB1cXJV?=
 =?utf-8?B?d2JlMUlsVUlPZDZKMlgyQ0diVEk4ZlBYc2tubndJZ2dseHFSTktUOWppeXFD?=
 =?utf-8?B?TDhic2hpT0ljaHNDWDZiTm9oTXI2Q2h6V1BNWTd4eEdNbEZ4V2pKYTI5MnVw?=
 =?utf-8?B?QkpORngvV00rME1md1dGdzUyVnB2bnAvVWp4YTFXU2RLbFVRSS9VWjV0Qzkz?=
 =?utf-8?B?MU1NaEFqUW5oWW1vaHk2TkJ5TXE0ZVZYY2trcmVzZUtLN1NyVllIOFZtVUdT?=
 =?utf-8?B?N3dYYXJydVJscDRHUmxBZEFncVY2b3NpTjk3T0lsMDN5K2FzTytwbXdadFNB?=
 =?utf-8?B?U2Z4TWtqaVR6ZzRQWHNHS3NZVU1IdTZ6UUVSRVV1NExLVENPUWtOTktnallT?=
 =?utf-8?B?c3ExdTZ5OE1CR3hNNDZpWEpXV0V4bHBlSzZqWmVab0R2bk40S1NUQ0RuOXgz?=
 =?utf-8?B?K1ZNNkpEZkpLMnVVbWJ6QVJXUmFMbHlLUThncXlQK29sNm13bGRVUjZBZlU5?=
 =?utf-8?B?dUNBUzN2YVFLdWJxWVNuRjQyYzdDTkEwQUJEUHlwUGlDczlBOS9DdHF0M3ZE?=
 =?utf-8?B?cmZndndVTytEZU9vYjlmeStyNWVzZjVtajI2MUcyZ3lES0ZFNlM4aFhWYThx?=
 =?utf-8?B?amVHNCtWQXRHampzRDlOTlhib3ZaSUxpd0pCK2Y3YTFqMFN5WmVpNVRrbVNM?=
 =?utf-8?B?ZFdib2w4N0RzQXAvd0Rwa01oMUpmSjdBaFl4RXkrWXpvbTJPK0N0UnpUcmlX?=
 =?utf-8?B?NDYyTHNtWllzYlNlRjVjMjZqZWNCVjJXa2hLbUc4c29LMGtyWFQvSlBncTJK?=
 =?utf-8?B?ODJ4M1o3Umk3VUlMbndHazdYaE9WTjN2RUxJNElzZE56MXlxRlRSblA5aGdj?=
 =?utf-8?B?anBwZU40V3o0ZW44QlJHMElqT1VENXVIVXFIeXc0K29OTFN4WGQzeS9KM1Ft?=
 =?utf-8?B?VUMvajJTNnlNTGc2M0ZPemZTQ0N2R2hYeU5lYWVSUlVQZVNDNGtEblc1WFYr?=
 =?utf-8?B?akFYbXl1THlBZXoweFo0WjU3VE5RcVVRU1lSZjhIK282dkJjeE5JanI0a2lt?=
 =?utf-8?B?WGsvQmU5dXQ5bEpNOWtHWFVqa3dJWTdwaFEvR3p5MUV6NE5sTnVQeS9wbkdx?=
 =?utf-8?B?dGR4V2hsSWJ5TEU5bEU5dzZDN0ltRGV2QkNNNXFCdUxDWmZZb2tldHIwZGpa?=
 =?utf-8?B?OFE2Q2FSOXNWNW5GUy8yOVNHdDNTNkNHZ1RIbC9SNG9DQ3AySGZvWjRoUlJG?=
 =?utf-8?B?bWs4dXB6T3NvdW1HZytCM0hqaDdYVmxLQWgwcHk2MHRVaXUvbkFKbWE4a2d1?=
 =?utf-8?B?cjdmY0pDdldMTjEvcitZUDg3Y291d0NKREVIbFAzbGhmSjNWY25CaHBKU2Z6?=
 =?utf-8?B?RWZwSnFMTWN3SUR4WWdubXFBY0ozVFlKa25qVDRPd1ZmdURObGJZcGZtVFF6?=
 =?utf-8?B?a0M3UUZKRHM1RTdUbHZYUUN5WUNwZEwxWGFOQlVpa1BzRTA1eGVOMzJjeW5B?=
 =?utf-8?B?akNubVhTSUhHa1l3bXpKK29LRlJCRDV3NWF0T01xZzVnZk5Sc28vYnNkbjhJ?=
 =?utf-8?B?RmhQRmlwUkpCcXVZYVNObDJEQ0pvVFN5bjRiOGRjWU9wU053Z1VYNUI1d2Yx?=
 =?utf-8?B?RXhjZHhMMVVLQllaSHg2L1V3d0tZUFE0TkdvMHNmcThMcTlVSHBJbmFtajJR?=
 =?utf-8?B?YnJmOUhEMWJGYmhOd2dTQTF6UlVUa2RtNkpEOTRRY3dtWEpNdmhacmhtTnU5?=
 =?utf-8?Q?Zgqr+i7CRH7zN1p4yRY2GyRZIMq+l67naNwcs=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(1800799021)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dm9uQ2gwenNQcVZRc1lub3kwWDR0dko2RXA1RzEyM0N5QTBlQ1VxaEhOS1Rm?=
 =?utf-8?B?WHY2UjhEWHVIQjNVbUFuK0NZZUR6aVRCbllmWkowQllSTC9tTUxEZVZqSi9l?=
 =?utf-8?B?b082Z3J4YnVuU0NVWVBuZExLVlZLL1VmYnVlM0V1SSs3Lzhvb1gvdHN4QXIx?=
 =?utf-8?B?NHBsV3JCQS9raWVIUTJlWHVzTkQ2aDhCcStzVGJuQjZSTnl3ZDgwWDdxZmk5?=
 =?utf-8?B?VjB3T1RuVTJEWU1LNVVPb1M5QUtpMmJsSnM5K1JJNEhiK0p0S0JDWHU3dDFI?=
 =?utf-8?B?eUxtN2xISDcrdUpFYXlsZHJXSmgwaUpRTGg0L3pDaUdmOUVzR296TVhwZEpi?=
 =?utf-8?B?VTk5blRCNTNxZWc2NG1uR0E0Z3piZVk0NkZrNmZRWFhZUWYxNWVqOW5ZUEJK?=
 =?utf-8?B?anA2OEdzbXFHd1dweExnSFVaUmVISldESjlvb0tYRVpDb1ZlNXNCRUdGMkRQ?=
 =?utf-8?B?SjRoZXpFNzhWL1RIRFhRYnR6eThIUUdxNUVGZU1idytPeWZGcWpuWEtzUS90?=
 =?utf-8?B?dFQ4VGlqZjBta0d3U2VpQlBlNSs3RjRRdUVRUENRNUxDcUwySkNDYnBYOFBh?=
 =?utf-8?B?d3EvSFJabGhPTFBuMkdLT2I4V1IxQ0FMOWd2Sm5aQy9hVkVlTmhkQ1RsZ1pX?=
 =?utf-8?B?ZjVrekoxejhwTXloRmJHRkJyTUpFY09Zb2I5c0VIbGt5VktyZmZYZGkxVlEz?=
 =?utf-8?B?N1NmTmY3b2dOczFiWUgzQzVYMSs3QzBjaEUvMXlydW5EdmFuZmVjdlZpL0Fx?=
 =?utf-8?B?VXc2YWs2Mk1XbVc4WFQ1cU8zWkFuMU9aL2U1ZHlNQVdtUExQaHY3TmlhRjlP?=
 =?utf-8?B?UlhYN1p2SjdNdEVxeG9WV0xBUzM2dFMzUGY5dDV4dzVGZGowaFUvOVdjTHRl?=
 =?utf-8?B?Q2lUY1NvR2pVc3g4dTFzb2VZVnpVb0JURG0rWEFOTGNQbmRDMU9LL3NqQk9r?=
 =?utf-8?B?N2RaTnlQWWV5NFY4WEVVRjluNFBGSklXMmtpZkFoTm9FdlduN3hTRmtNeWZv?=
 =?utf-8?B?SDgyTlZGK0pjcUNzaG13TVlRb0RVbmpKTlZtbVAxKzFsZTNKRHBydTZSNVpi?=
 =?utf-8?B?VGxNeE9PRGZKSUNDYTRwM3dVUEg4NzVyc3FYS2lYMHY3dGlqWVl0ZktSVms3?=
 =?utf-8?B?N201OU1NZXVZV2pWa1Voblk0NkhQKzByN3QrSlViYlBUT3QzcXM0dEhNanVt?=
 =?utf-8?B?cVpScmtMekVqUkRWeHNObnNlTjZTV3FoNU5Nbk4vYU42RU9VTmdGZ3pTODF4?=
 =?utf-8?B?blE5aWtFeDZ5b0lkVzlpNXpOM2w4WFNXR1lNdDdIMTFneHhPajhuRUY1eG5Z?=
 =?utf-8?B?M1JWOUxld05BTGJBekNtOXFTeFgza2FKeUFOZTFlRFlpRUNXdGEvVEl6UVlX?=
 =?utf-8?B?ZjhCSE1DT3FNUW1lUk5ZV1hwZEVncDZ4V1lLbGh4WnNqNTV3T3dvcWo1N0xW?=
 =?utf-8?B?dGUwbzE2bEM3ZU9MWHVkU3hQdnNUWUtOUHpjektlYlgvTitGdHNlbDA5Z0F5?=
 =?utf-8?B?Ny9rM0VxaHVnS0swMmlyZXYvTWJJb3lFdXZkM01QWEVDbTI3Y1IxdkN0M0VT?=
 =?utf-8?B?QzZ6TzR6ZVZrbm9QVU1OR2E2WjQrbWVucStMa3JiVG1wemM2c2FRNlRtWUF2?=
 =?utf-8?B?WmtydXBLaEJMQlRTUmJnOGlRSzBqbG42VXM1QzFWN0hxcUFVN0FPYiswQk5H?=
 =?utf-8?B?THBlZGk5dDVtdFQvYmlSZThGMldEQVlFVXRsTnFRbmF4aExmd0kyUko4ZGln?=
 =?utf-8?B?SzR0em9oNTBKM29uSTV5clNEZzFrVFhpUjB5bmFRdW1tcTR0Ym9MVTNJSTFS?=
 =?utf-8?B?UVpBM1dqRjFzU0xiUS9oVWtHbE8xQ2xkRXl1Qk5yQ0Z4SUYvWmcxREdlYk9Z?=
 =?utf-8?B?N1ZnT0ZmSkFYcW1uK2V4Q2hwRjZlaTBKSU15L1hPSTFHczl5MEx3dVhYajh2?=
 =?utf-8?B?WTQ3ZkJ1QXp1V1RjVlNwYnpPTWx5UWdRbXBSRTBvekVUZVhDZjNlcTEvRTB5?=
 =?utf-8?B?ODFrbDI2cHpzWGFBZFF5bDl0a2hLWVRTTnJQOUdmclVKR1Q2QVMyWGRGMmhN?=
 =?utf-8?B?NmFzWFc3K0xiUEg3WlhxaGtwK1JHRS93WFluYUFoclNVdzRIOTdsSDBPc1Zu?=
 =?utf-8?Q?nRrJ0SkfJZWxkjTypKbzWhi52?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <05F5CD2040DD1B47A72D764E9E082097@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	JF5tBG697tL0cOobj1L5IYGEMuV19at0qU203ZI/6sV8rZZCKcA98jVSTBT+VFYZ2UuagyonrV/tkQYI2LJ6Kx2PTirtiKH2xS3mSL4gRuQ0VeiqIKdsx6p37Ky/oBZqDwsnN1CLA9rEwSAHeRJrDof5Kvt84TouKgaG0mz94bMUSGYTtQpTwDgpkJz8GtORpmYyzflcW8TLBqEkfwKfNxnkQJJ8qGrGq+HQ/yBlwymJeG2myzlF7i5VBLbAPWmSRwMqIdxat388A+9LIr8QYq0oMXNzgCnKMSqLbJMJiPs1HnhzKVky6mguSYKbIl6BXhQ7eMR05on0CF8ssrNfBAXFrTsh593u5VLon08GiH1bGqP2qHRfAt7kYuimn5zvve7O+wEgkRsb88rl9XNRhRcZ9MnN9xv5QIpdVKi08akOHlRZTy3jYO+n1QfcU2fBehineRcDwCw1DDTDPALhVP2BOd1mzlKJ2oWWM2dsj/AntdCnriOgBOiNnz2LsaIbXcG34anOww1cFqtanSqfX3QWTGr3JCRlolyeVILIdqqRtZA2zdD3KLa0K/4RBGkkm+pwbA6iFMBiVgcW/yWgvBRkzbwoDh7424GbrshgdTOS7HDGSMcCod6gDO2zyj3M/rGcIbDf0018ZuIIjMtGGw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f21f0ea-1011-4a3f-20a7-08dc924f086a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2024 00:05:32.0465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tBQT3EkcQog8Bn0S5Nc1X6frUkaxkiZtcrRVQGk4PsmBR5prSFppTMK+Sn1iIsPiC8V673qEOtPP+4gSUCngeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7749
X-Proofpoint-ORIG-GUID: O9qlwvnmVFAxyOTMUsORc0qvFAwNojvZ
X-Proofpoint-GUID: O9qlwvnmVFAxyOTMUsORc0qvFAwNojvZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_12,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 clxscore=1011
 spamscore=0 suspectscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406210175

U29ycnkgZm9yIHRoZSBkZWxheSByZXNwb25zZSByZWdhcmRpbmcgdGhpcy4NCg0KT24gV2VkLCBK
dW4gMTksIDIwMjQsIGpvc3dhbmcgd3JvdGU6DQo+IEhpIFRoaW5oDQo+IA0KPiBUaGUgd29ya2Fy
b3VuZCBzb2x1dGlvbiBwcm92aWRlZCBieSB5b3VyIGNvbXBhbnkgZm9yIHRoaXMgaXNzdWUgaXMg
YXMgZm9sbG93czoNCj4gICBXb3JrYXJvdW5k77yaaWYgdGhlIHBoeSBzdXBwb3J0IGRpcmVjdCBQ
MyB0byBQMiB0cmFuc2l0aW9u77yMcHJvZ3JhbQ0KPiBHVVNCM1BJUEVDVEwuUDNQMlRyYW5vaz0x
DQo+IA0KPiBBcyB0aGUgZGF0YWJvb2sgbWVudGlvbnM6DQo+IFRoaXMgYml0IGlzIHVzZWQgb25s
eSBmb3Igc29tZSBub24tU3lub3BzeXMgUEhZcyB0aGF0IGNhbm5vdCBkbyBMRlBTIGluIFAzLg0K
PiBUaGlzIGJpdCBpcyB1c2VkIGJ5IHRoaXJkLXBhcnR5IFNTIFBIWS4gSXQgbXVzdCBiZSBzZXQg
dG8gJzAnIGZvciBTeW5vcHN5cyBQSFkuDQo+IA0KPiBGb3IgU3lub3BzeXMgUEhZLCBpZiB0aGlz
IGJpdCBpcyBzZXQgdG8gIjEiLCB3aWxsIGl0IGNhdXNlIHVua25vd24gcHJvYmxlbXM/DQo+IFBs
ZWFzZSBoZWxwIGNvbmZpcm0gdGhpcywgdGhhbmsgeW91IQ0KPiANCg0KVGhhdCBkZXBlbmRzIG9u
IHdoYXQgeW91ciB1c2UgY2FzZSBhbmQgcmVxdWlyZW1lbnRzIGFyZS4NCg0KSSd2ZSByZXZpZXdl
ZCB0aGlzIGNhc2UuIFRoZSBpbXBhY3QgdG8gdGhpcyBpc3N1ZSBpcyB0aGF0IHBvd2VyIHN0YXRl
DQpjaGFuZ2UgbWF5IHRha2UgbG9uZ2VyIHRoYW4gZXhwZWN0ZWQuIEl0IG1heSB2aW9sYXRlIHRo
ZSBQSVBFIHNwZWMsIGJ1dA0KZnVuY3Rpb25hbGx5LCBhdCBsZWFzdCBmb3IgaG93IGxpbnV4IGRy
aXZlcnMgYXJlIGhhbmRsZWQsIEknbSBub3QgY2xlYXINCm9uIGhvdyB0aGlzIHdpbGwgaW1wYWN0
IHRoZSB0eXBpY2FsIHVzZXIuDQoNCkNhbiB5b3UgaGVscCBjbGFyaWZ5IHlvdXIgdXNlIGNhc2Ug
YW5kIHdoYXQgZG9lcyB0aGlzIHJlc29sdmUgYmVzaWRlIHRoZQ0KZmFjdCB0aGF0IGl0IHdvcmth
cm91bmQgdGhlIGluY3JlYXNlIGxhdGVuY3kvcmVzcG9uc2UgdGltZS4NCg0KVGhhbmtzLA0KVGhp
bmg=

