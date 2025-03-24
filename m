Return-Path: <linux-kernel+bounces-573697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D92EA6DAEA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFEFA16D29B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D640625DAFA;
	Mon, 24 Mar 2025 13:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Ci2wQpQ6"
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3389EEC5
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742822267; cv=none; b=HMOyZexSk/4dgpOuf6gk2P+MS8lruwwIXs6Dl6HjMF4aFDVhA1mAdssicHhWn4UQynYdoBLpls/29LYm8y7842fjsVPK3O6m7XpG89TZIBcDrfcWyuTl7hSWxM5tKiqk3HYaBpM25rA/apdN0quDtgk/r9BNL2KT/3vFQsjOB1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742822267; c=relaxed/simple;
	bh=7xw4Pt+tgnWHdphFQSfNt/S/7vLaSS3qWNbuMz7nIm8=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=oYLwHXCvlasTx2dMYA6GlGPh5JCfLSsH46JLY5r4d8AFd5m7LlgBpoH7Or+2avMns6obPe8xAx4bs8jlAWP5DzbYGs4qWgAUXJ3LvAJY8n0E7zBsXSX86GrVHICunoMhefWrA4EfyaALTNABFFf2b6vyiuejpgtZGq3IKhc5CNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Ci2wQpQ6; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1742822254; x=1743081454;
	bh=7xw4Pt+tgnWHdphFQSfNt/S/7vLaSS3qWNbuMz7nIm8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=Ci2wQpQ6rtHX5W4Za1atGvvd/j60vtbHTG4WfDf3ILfdNUIsDM+O1cOSRvrWVicUW
	 T9qHoUySbfJvBIVkY84su85UaDnElaV60RPmT+vVBpCNQpzNOEP3MuGSwDDpP0mKcG
	 hIHg0ayRjrpHMPVtZGt86W2acITRgS9qvGymt6a9chEdgNb/Rl5nkH/BCAk5tJBtp4
	 e6vzoN3J2xybeetLMYnbgrokl6wWtDFsXhKT9dB+iUzYQt7yYa98lJUASE1ziLRpx4
	 5hHWuivq5pe5Yoo3vTFc0eeVJ8611S2+wwT4741wD3ydf++X11B87IVFdK3Omd332/
	 32yamxeuDi2tg==
Date: Mon, 24 Mar 2025 13:17:27 +0000
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: Finally RHEL 10 and its derivatives are using Linux Kernel 6.x
Message-ID: <Jvrsqm5M9lnr2ajZjn60wJpwGTHmLWGKGiIR3NXnfSwnmKbVcHC2A5bcezDD3R1oSE61BfSoRiu3UwGUgaoYHBHV8KZs7zsGA3WPRDW-uhM=@protonmail.com>
Feedback-ID: 39510961:user:proton
X-Pm-Message-ID: c9883733f0b0cc4f3079bfce2433032dba89c729
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Subject: Finally RHEL 10 and its derivatives are using Linux Kernel 6.x

Good day from Singapore,

From Google Generative AI:

Red Hat Enterprise Linux (RHEL) 10, in its beta stage, is built on the Linu=
x kernel version 6.11.0.=20
Here's a more detailed breakdown:
RHEL 10 Beta Kernel: The beta release of RHEL 10 uses kernel version 6.11.0=
.=20
RHEL 9 Kernel: RHEL 9 uses kernel version 5.14.0.=20
CentOS Stream 10 Kernel: CentOS Stream 10, which is closely related to RHEL=
, is now on kernel 6.12.=20
RHEL 10 Codename: The release has a codename of 'Coughlan'.=20
RHEL 10 General Availability: RHEL 10 is expected to reach general availabi=
lity in mid-2025.=20
RHEL 10 Features: RHEL 10 includes updates to libraries like OpenSSH, SELin=
ux, and Podman, as well as updates to dev tools and languages.=20
RHEL 10 is based on Fedora 40=20

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Targeted Individuals in Singapore
GIMP =3D Government-Induced Medical Problems
24 Mar 2025 Monday






