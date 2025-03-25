Return-Path: <linux-kernel+bounces-576197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDB6A70C3F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 300C61767F3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E85F269AF4;
	Tue, 25 Mar 2025 21:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="PWpoQSUy"
Received: from qs51p00im-qukt01071702.me.com (qs51p00im-qukt01071702.me.com [17.57.155.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A7F179A3
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 21:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742938846; cv=none; b=A5VUujFgLSk47TxNtGgzbUBAWvveyGmqMGbQ5VzBFqhv7iFTPvlqPCSL/NfGLF0No4AwQ0SoQOVo5w8gOMpp/MJe9KlMNZ/gJoiB2mLjdH3/NEK8UXH5kUdjwE4sDVPMxH/uz9FxeBKJ6pNweBMssh36HARfyND+7nJMyhj0aSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742938846; c=relaxed/simple;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:Cc:To; b=hgC5yO3LK8VXcY9n7VfS5t72tW63T8dXDW6iL9qBl3ToDFtz6BbdmjwpfYLfLBhuL1iJdX95PLd23QnH71wtnMwb5aP5VuyhoT/RH5XfJtzf+KSghHoHV5DKpw9uXlmK/zYFRxL8NdNIdOyZ857GHDrBbMklB7J8jWEOrdXAIGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=PWpoQSUy; arc=none smtp.client-ip=17.57.155.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:To:x-icloud-hme;
	b=PWpoQSUyEiaOtTeauJvr2xFEGue1ZyGJDNs73xw9ox217GH96k03fR+O8qk3/aTNP
	 C3fM4QSRDSh7V9P/gpxrqVWGmFmmhifiFvokIKrCHMskMTF64O0jFrNYTPearcG+Rw
	 xNn8nDtud7SVfal32DizOgNt5Eygonm6FlZ7UHtsk0mNev4JBPg17Ow/bTf+VW5rnF
	 o3SQuevP6TB4cQelIkEs6D/0s3AgEfgnluCNmG7ZLSw7oRzzrv7GifgfHQDUawvQeM
	 +tvq4RE3iKFeDVdAA1srgqCinFpfRZ6zCn56yLuomS+60X0xxBCs22Au29a60xrdsM
	 vKm4/ZQHaXrvw==
Received: from smtpclient.apple (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01071702.me.com (Postfix) with ESMTPSA id 6621A35002A9;
	Tue, 25 Mar 2025 21:40:41 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Adnan-khan Ruzwan1 <adnan500p@icloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 3/3] tracing: Rename trace_synth() to synth_event_trace2()
Date: Wed, 26 Mar 2025 02:40:34 +0500
Message-Id: <05340ACE-0A78-4D2F-BF1C-57EFE6EEF633@icloud.com>
Cc: aliceryhl@google.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 mhiramat@kernel.org, rostedt@goodmis.org
To: douglas.raillard@arm.com
X-Mailer: iPhone Mail (22E5216h)
X-Proofpoint-GUID: 9BmlzkDiGkAUy_EOw_zc9a4ALMkHlSBR
X-Proofpoint-ORIG-GUID: 9BmlzkDiGkAUy_EOw_zc9a4ALMkHlSBR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_09,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 mlxlogscore=582
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2503250144
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8


Sent from my iPhone

