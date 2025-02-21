Return-Path: <linux-kernel+bounces-526467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9706A3FF05
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FD14161FB8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869372512C3;
	Fri, 21 Feb 2025 18:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="0GOAwDtb"
Received: from qs51p00im-qukt01072101.me.com (qs51p00im-qukt01072101.me.com [17.57.155.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53EA1F7561
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 18:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740163493; cv=none; b=ZzBbxhQQSdphTiR27h41g95okJJ9uPPmF0/gmRmofvdlnoli7+TClhLlidVR4Vjf2az+j12/lu2qoUwC2uCW/WR7lw20Jwgd5y+7LmO2CMXUo+L2xR6lLmf7idZsauVAtuFiIAUFN2DXpmXMzkYxbeLY5PtJB7uHAYE23xchcEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740163493; c=relaxed/simple;
	bh=KnR4EzoEBt+ftRx4nnv86SWVgm+uf9RfVItsvP3UHHs=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:Cc:To; b=Yh0oQ5dXbeUneD4JkNSYZVoYx/t59W1gylZCPwgZW6DLIfyP+W2sVJHbwoiFXVKmsA35Ey27ONcud+f/HbEYw3HgXrX5u/ARFxjSi0nUsLsl6V/3VSchRDYJxa6MHGoYn5fvyCe7Yg3KaeGtOJ0IaB1xbJiYj+eal4O5O0DyBVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=0GOAwDtb; arc=none smtp.client-ip=17.57.155.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=KnR4EzoEBt+ftRx4nnv86SWVgm+uf9RfVItsvP3UHHs=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:x-icloud-hme;
	b=0GOAwDtb8TvFA5B0Tmj7wIdC2s+yxYpzThjDF64LXoPA9MmmQPs7OAqHaJNkBdqve
	 3vt6P53wPJtzsNTYS2gT1iz9lArQkc6ASiDwWApPl3TgO47LrzO51TzCT+3BJzzARe
	 jAk/0tneOx3ufdvf5b3U3RG8LC+vsUdogx6lNXFOZQSCbW8Z0pFiBNvn0Wma7yghvN
	 qk7MmSXnMOj26erXiqaYmYAMBC9J+7RVZMocg5yM3Ux2frvQEjT06Jc35vYOMPRISK
	 LTqjt/MVPMZ0ODJIFfnH66mOckRwtBw1KnuUtg82jI+LnW14BozltAEnkeWzBfRlZ6
	 2GjCgD0Wlft9g==
Received: from smtpclient.apple (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01072101.me.com (Postfix) with ESMTPSA id D2780402AD;
	Fri, 21 Feb 2025 18:44:47 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: MICHAEL TURNER <kameronwayneturner@icloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Fri, 21 Feb 2025 12:44:29 -0600
Subject: Re: [PATCH v2 2/3] rust: configfs: introduce rust support for configfs
Message-Id: <2930AE30-63B7-4CD7-99A9-096AB6A06EC5@icloud.com>
Cc: alex.gaynor@gmail.com, aliceryhl@google.com, benno.lossin@proton.me,
 bjorn3_gh@protonmail.com, boqun.feng@gmail.com, charmitro@posteo.net,
 dakr@kernel.org, gary@garyguo.net, hch@lst.de, jlbec@evilplan.org,
 linux-kernel@vger.kernel.org, longman@redhat.com, me@kloenk.dev,
 mingo@redhat.com, ojeda@kernel.org, peterz@infradead.org,
 rust-for-linux@vger.kernel.org, tmgross@umich.edu, will@kernel.org
To: a.hindborg@kernel.org
X-Mailer: iPhone Mail (22D72)
X-Proofpoint-ORIG-GUID: YXtC74PVPtZruquuXKpV8S6UpvQSHG3I
X-Proofpoint-GUID: YXtC74PVPtZruquuXKpV8S6UpvQSHG3I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=555
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2502210129

Need help deleting all processes=20
I didn=E2=80=99t want non of this=20
No url no kernel functions=20
This is theft=20
Against my will
Sent from my iPhone=

