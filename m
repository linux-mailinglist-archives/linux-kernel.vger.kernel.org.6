Return-Path: <linux-kernel+bounces-343432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 080AC989AD2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 08:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDFB928187F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 06:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1843515382F;
	Mon, 30 Sep 2024 06:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="Q4nf32ki"
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4395A7AA;
	Mon, 30 Sep 2024 06:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727678732; cv=fail; b=bXiHCa7mg+s5zfia3pCaqiRatcGrp6Dr+Von5H8eFtjrNs2SzEia1IrOl6+KP6oj8JpOdhXuL/QZ9/ewgCTL8l6ZkeQMYqOMF6N2rK7YkEHvLl5qSCwOLANRWQ+VgWaN3cZPP3AKEbYjrC9jWwqjtf7zOtpguFv8JjZjlWSzu7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727678732; c=relaxed/simple;
	bh=XkYFTI7YBQIqGZ+Kf6sVaafJ2YG84YFXmBh4RGqcIDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNzKo4pZc3PjXmQEGcwqPJmvN5NB2FCQO1nAzxBmMiexVmEE/qbLJD51gjb0P74v82jpIY/V5OZEDpkKnTjE8fQxbDyWfsRL5eWKiKlZsGiHxCkGKUS1Ytq8kxt75LM/6fHuf/fZ4H/oOz0n4h4RrZf2VO52CYhNH+u2hzU1SH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=Q4nf32ki; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48U2widd027365;
	Mon, 30 Sep 2024 06:45:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=fYYKjp/
	oA90nanAB7PxyjnQ0wIP/UMkEAD+VTBLLl3o=; b=Q4nf32kiaBYGdz7ZnqDBXSV
	NO4JdxhSPViQ09cl8blG389a46D0hFUCjl9wFi6ukkjyxqdPA33S4stggGUY/k9I
	N/3EMznDtFBCPD7Nt5fX3Nd1wdWiGgS0KfgDCLcFpnMGv4EWPRUGJ82IlP8H80Nh
	qsK4jZc2LKLa/xA5hsUtmP2N0wA2VrVE9FxL2aZ3tfaK9b4TV/jWdzpSq7/lqUnv
	OKpAj4yoMN8jlItD8kP/uv3tVYlpuvp9QZflB8LnFlqBhByECYlsuINZUYMLEMXZ
	CqCNVW8oifKrOPjT2XT6puLTph8dTRKB0HbbfxpP8THJvAVN+eZOgkQ+4EHO1xw=
	=
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 41ygq98a8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 06:45:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mA0sKZQ60OeLJkcXjqGxlN6ykFoqAYk8ewLKotFWS7008wfBstOHmypfwWesIKCJ++BDrJcOluUa9GEUjdEeV2HlWve1EFvFA4Pl6elI1HOuzsd8oLD7AxW0kylFhxPhh+Dq6zNIYTCV9eRd/yAS5ogTf7u3xUu04tt+8OaA2Z3f5ANRFPQhdsjkBmqusSGtnFDl5iBm8njr4Arlzj0C+6icG46Z1+yl6xIfP+LQO8jJL6BKh3/hYVO5NHfVX395TuF3zZAofQpP4VKS3Uu6Soy7rS39fXPGaZOSyq6n0IYBjOB3fspQhcuHwE2pWtjKGMPaEq9Wdy89pVJ0fmCvOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYYKjp/oA90nanAB7PxyjnQ0wIP/UMkEAD+VTBLLl3o=;
 b=uarSZf36kb2LkRO9MitSMBToyNDxGVmFZV0HTkzWdjC6oqwr9y0UW7boOKzgT6p75NAz73s0wP9wAKFZKchsCT6E12Y2KdqaHZlc/7k4DxFyQCbP4OYFwTrLzXbDbshEyJRkR8vsZFjicExmDwo8lH8lvLKWNGMoM9uit7BO1CzuxQ4orDxcnFUrCS2lcEF7w9s42efvqLGmfEwQtzDOltnKO74FeZ8cI7+sKewZ+pPZhghyTHRtJcWFKtGzbqt3cTZJZGrcoAQ5uFT+mEexyIVbsqlz0v6gI5qjIfcvLI97ED3+OcJ0pdN3xXwYjMyuG7AhmityYwNFrI7GStUSaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 121.100.38.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sony.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none (0)
Received: from BL0PR0102CA0026.prod.exchangelabs.com (2603:10b6:207:18::39) by
 LV3PR13MB6547.namprd13.prod.outlook.com (2603:10b6:408:1b0::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.26; Mon, 30 Sep 2024 06:45:17 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:207:18:cafe::f8) by BL0PR0102CA0026.outlook.office365.com
 (2603:10b6:207:18::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Mon, 30 Sep 2024 06:45:17 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 121.100.38.198)
 smtp.mailfrom=sony.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=sony.com;
Received-SPF: Fail (protection.outlook.com: domain of sony.com does not
 designate 121.100.38.198 as permitted sender)
 receiver=protection.outlook.com; client-ip=121.100.38.198;
 helo=gepdcl09.sg.gdce.sony.com.sg;
Received: from gepdcl09.sg.gdce.sony.com.sg (121.100.38.198) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.1 via Frontend Transport; Mon, 30 Sep 2024 06:45:16 +0000
Received: from gepdcl04.s.gdce.sony.com.sg (SGGDCSE1NS08.sony.com.sg [146.215.123.198])
	by gepdcl09.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 48U6jEiF024056;
	Mon, 30 Sep 2024 14:45:14 +0800
Received: from mail.sony.com ([43.88.80.182])
	by gepdcl04.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 48U6jCCv011162;
	Mon, 30 Sep 2024 14:45:13 +0800
Received: by mail.sony.com (Postfix, from userid 1000)
	id 24A281BA903B; Mon, 30 Sep 2024 12:42:36 +0530 (IST)
Date: Mon, 30 Sep 2024 12:42:36 +0530
From: Nayeemahmed Badebade <nayeemahmed.badebade@sony.com>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, krzk+dt@kernel.org,
        conor+dt@kernel.org, rafael@kernel.org, yoshihiro.toyama@sony.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/2] Add framework for user controlled driver probes
Message-ID: <ZvpPZCrOzVxQbtjq@NAB-HP-ProDesk-600sony.com>
References: <20240911142319.3435746-1-nayeemahmed.badebade@sony.com>
 <2024091327-repacking-avatar-ec23@gregkh>
 <ZulGr8Ul7y0T0NkQ@NAB-HP-ProDesk-600sony.com>
 <26fed82b-7c60-4fda-8951-b22654728743@kernel.org>
 <2024091747-monorail-unbutton-7ebd@gregkh>
 <ZvVAiVBlBjkMhHMY@NAB-HP-ProDesk-600sony.com>
 <43447165-37f9-4b35-ace6-8d32760f75a8@kernel.org>
 <ZvbP2e8nZzjXKfVK@NAB-HP-ProDesk-600sony.com>
 <CAL_JsqKLT_H5jMnZYrpaZ246YmDtZHg7eQ6PJVp7sykVi3SG0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKLT_H5jMnZYrpaZ246YmDtZHg7eQ6PJVp7sykVi3SG0A@mail.gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|LV3PR13MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: 84b61ef7-d4ad-4b19-e44c-08dce11b71c1
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFVDVVA5eHBScGtoaUNMOFl2bzlkVHJZYXNjZk9GU29iK1B6RHRXcWF3Nk9y?=
 =?utf-8?B?NlVmcXpWRzdNM1o0d3VKdlNiUVZ6bEZ6Ti84L3M4ZndMQjBBUERTRTh0aXVU?=
 =?utf-8?B?c1NqbklMcTQyTFUyOW1CZFk3RFhVUlRrNlFzRTRCMFVpYXlMQzN2QjdxODdU?=
 =?utf-8?B?K2tzMmxROURaMGMzMERnQjhKUEVpM0dESFpZSmVJdzMwaTJxUzBNQ0YxeVNE?=
 =?utf-8?B?eEdVR3E3RjhaTGQ0R1QrekFmL1dVc1c0bWZRTTZNc01yQjF6dG16ekRzVFg1?=
 =?utf-8?B?YlZnWk1sdnQ5N1dETjdEY2hXQUV1YXBKcTE2VmxkVDI0Wkd5am1vektwZ3J6?=
 =?utf-8?B?dUR0VC9ZZ2loT3Y0dHVzTjdUTnlkN0QyTHlGMFJ3eFNhOTR4THA5L1JEZzZZ?=
 =?utf-8?B?b2dVeHV0bGN6UEN4Mk5mVVZXNmQzcEMyNGJzek9wVUg0YkpJS1VCdEswVDhu?=
 =?utf-8?B?Tjlib1RPNWNhdkN3cUo5NWFuQVVDbW85WmJCNmFqSHoxaVMvNFlDelplcjJk?=
 =?utf-8?B?ZmFWbHV4ZFRDU014ekNpWDh2eWsyY1ZvOUhEQUt5cDJtcFlmbk03YkRxWkNI?=
 =?utf-8?B?eXYyZUlhSEEycDdpZTdrb1B1c1p0YTV1OVViVmhieEFmMnhkMGY1RDFpdjJK?=
 =?utf-8?B?ZXdsTU9PVlhHV3NvUjdHRkdLZ2kzeUxXTFFhYUdzWWtaNXFhWkFZcjMvR1JH?=
 =?utf-8?B?enVGalVCYUZHcmROeW1uS0MvTS9mUG9ZWWxZVzlsaDNWVEtJL2pNQ0l5a0ly?=
 =?utf-8?B?cFRUcHduTWl5cURnL0Q0NXBjY1VmWjNRUU9nV0VHSndNQm1pR21sWmZEK0Jt?=
 =?utf-8?B?WWdraVZQVUtTTUh2VVV4TlNiUmVFc0hOT2RVSitLYzNPcmxrang3SmlMYTVY?=
 =?utf-8?B?TTVEbllhY21HWmFVSksrQnptOGprb2VRVDVJU3RIcWFiNjJnSUdyUGJQOVoz?=
 =?utf-8?B?cWFlMldqNUVhVzNWeXFYTDFMeTg5Z1NjR2IzWkVjOTg1SWE1TDJmL1dOZnFp?=
 =?utf-8?B?QnMxM0NZMExjS3dmWHJkT1Z3V1ZWTTA5QU1FeEU2OURDTzh6RmtHdlZtUktq?=
 =?utf-8?B?ZVRmMWVIZjhBTmtpeG9XUGx0bHhPcERQdUNmTHUyTnpCd3d6WitTMGhtOGtj?=
 =?utf-8?B?U2RzT0ljeDhEZkxhUkNTS2dsZjNKejlteGF4VFYrMEtqOGJVV3VmVFA5RHcr?=
 =?utf-8?B?YkxkNUZyNWV4czRnaGNuVnltaHlkTVdZTUd2VUhBQ3dYSnZNYTR3OWZ5YzBx?=
 =?utf-8?B?bnhVSUhTNktNUllLQzFRbnlyanRyOTJiLzMrbG1LTUw1MkRLYit2ZzZIWmtI?=
 =?utf-8?B?YzNtWUo2MFlCeTM0ZEgxU1dyUE80RjBQcFlZUjF1QkJnVWpFWGNCclI1bXFC?=
 =?utf-8?B?Z2FpMzlwZ2t2NTdxOVBPVFYxZW9vNGxRQkc3VXdjVkhkRUhlTjFvbVZwbkxw?=
 =?utf-8?B?OXNoRFQ3b0ZMSHRrNWZWdjNMeHN6VTJVNW8vNk9XUm9WODZDVVprZHpRdVox?=
 =?utf-8?B?K0wwc2w2bTBJZ3g3K1BvOS9hRCtPTDhObVVVRDVBUE9rd01tbUtUdnRnMVRK?=
 =?utf-8?B?OUxUdS9OMzdUS1htc2d5SC9JOE8zYnFmUzlvZ3NsTHV1S25jNEV0Tk9DYWph?=
 =?utf-8?B?WEZLcEppRVJGMTF0MTJJWDhuYzFteTdQcytqNys2T1hOVGwzeTB4bVdRZWli?=
 =?utf-8?B?ZTRQc0tHU0VudFZ4bmhVTjd2R084TGhuZEZ5Yk8yazF1V2UrSTNpdVVZY1dR?=
 =?utf-8?B?b3MzeXBocy84VmtKdm03cjkyMnZHNjUvd2NZeEl2bmRzbTZJbHlodG0xSC9O?=
 =?utf-8?B?OEFSVWNaTGcwVVlCQzg5ek5rVjRKWS9KT1BPY3B5Uzl5dDhTbWgxaE9ta3lT?=
 =?utf-8?Q?fAddB7iZrnHsa?=
X-Forefront-Antispam-Report:
	CIP:121.100.38.198;CTRY:SG;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:gepdcl09.sg.gdce.sony.com.sg;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gWHibXVOVgcjM3TxvoWizwItI0D+RJUsCM/Uhq2EDoDVhwY24MHOfRt3LT76QR6OhQaDUWaHAtxAj14CQJ7593S2Tcuu4lhd7BC8wxIa+PirzXRvbalwAcjO1Lci+FDkBzRoTFt5qZ2y5bz4tfVqy7oWE5TShULLzpRHX0NDZy1PVeed26WTodlBVLH7MSxZ87yWhDnCEiwNGMHkiBGZFLrW5Mri74shcfJH8Wq8heVEwOT5FUcvwfJnqG5ptnVa2pV6+/+6NI4LiH6bqvWB603vs4ufYdaPo3V1asQ89XyP3mVEmkjNq0+1+mL0ZvOEWBz2ZAaFwGjdGoNU0TvuStHdy5/fP6LJWBplaOhrcpJefI2uk8ena7ex01h/vPVnP2RNN8+3X4yCOSIbuvO14WGmtYXdmXU7rkyqy5XMWNsPvZ2sh34bRbvTEKSNr/waMbucGTg/FKvMpofOye3i7FStPGhikOM1YhQBJarOsKhIqPfO+TQWWmYcEpMwDEYjrIYkEQsy7u1e36E00eTPgDYQ7sKfJEIkk136KzfTo/E/ONL6SuW0g3f8u130EEI8KIi5rTdfldUFnGMBWoYDB1Kx6OxCbcYtA6Bczz9DaTySv8ZB47M8dFt8PaeO1uVE
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 06:45:16.1479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b61ef7-d4ad-4b19-e44c-08dce11b71c1
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[121.100.38.198];Helo=[gepdcl09.sg.gdce.sony.com.sg]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR13MB6547
X-Proofpoint-ORIG-GUID: BYkhPeoOVmxk0PXBCHfjqLkXwdjNR8cl
X-Proofpoint-GUID: BYkhPeoOVmxk0PXBCHfjqLkXwdjNR8cl
X-Sony-Outbound-GUID: BYkhPeoOVmxk0PXBCHfjqLkXwdjNR8cl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-30_06,2024-09-27_01,2024-09-02_01

On Fri, Sep 27, 2024 at 12:36:40PM -0500, Rob Herring wrote:
> On Fri, Sep 27, 2024 at 10:04 AM Nayeemahmed Badebade
> <nayeemahmed.badebade@sony.com> wrote:
> >
> > On Thu, Sep 26, 2024 at 02:34:26PM +0200, Krzysztof Kozlowski wrote:
> > > On 26/09/2024 13:07, Nayeemahmed Badebade wrote:
> > > >>
> > > >>>> not required at the time of booting.
> > > >>>> Example: drivers/pci/controller/dwc/pci-imx6.c
> > > >>
> > > >> Just this one?  I don't see anything obvious that can't turn that into a
> > > >> module, have you tried?  What went wrong?
> > > >>
> > > >
> > > > Yes we have tried building it as a module.
> > > > This driver currently registers abort handler for pci using function
> > > > hook_fault_code() on arm. This function is not exported and marked with __init
> > > > tag. So we can't use it post boot.
> > >
> > > Then this is something to fix.
> > >
> > Thank you for the suggestion.
> > As per discussion in below link, its mentioned that hooks should be static and
> > should not change during runtime due to locking support not being there.
> > So its not safe to export this function to use in modules as per the comments
> > there.
> > We would appreciate any suggestions you might have on any possible
> > alternatives.
> > > > Also from past attempt made to modularize this driver in community, we saw the
> > > > hook is not safe to be used post boot.
> > > > Reference:
> > > >  https://lore.kernel.org/linux-arm-kernel/1454889644-27830-2-git-send-email-paul.gortmaker@windriver.com/T/#m8995c6dcc40c54baef0665a7ee16d4209cb59655
> 
> The hook implementations have no interaction with the drivers other
> than being installed by the driver. So move them out of the drivers
> and the handler can be built-in with the driver as a module. For
> example, see arch/arm/mach-bcm/bcm_5301x.c. Could possibly combine
> some implementations. I haven't figured out why imx6 checks 2
> different instructions while keystone only handles one. But imx6's
> implementation being a superset should work for keystone perhaps.
> 
> Rob

Thank you for your suggestions Rob.
Yes, this seems reasonable and we will work on updating the driver
accordingly to build it as a module.

Regards,
Nayeem

