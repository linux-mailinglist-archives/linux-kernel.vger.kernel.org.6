Return-Path: <linux-kernel+bounces-516352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF75A36FFE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 18:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B93F16EAE7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 17:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4CB1EA7C4;
	Sat, 15 Feb 2025 17:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="HROX0Txe"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59E114A088;
	Sat, 15 Feb 2025 17:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739641693; cv=none; b=i53wBy36zNmuEZZMwbxeXLI9FhHXjLJ6Ah8GdN51/O9HKMVPZajJEmEq4W7lKtyLTx2enhsoaGxTzwQ9RF13Trf4YIKQ//fD8kBF2yq2/AaJe60UlUqlDqdKT62J8UK7fbRDDPl8FJsMO2gudqXAX1MMWkyj5FyX2bCzJdbGHl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739641693; c=relaxed/simple;
	bh=Bk0ww7KLjqAzjQcTV2y/Q475Pu+wJvf6577A84eAVd0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fsTBJarQnWcCCJ6DKpQOzvs3ah89Tp+ZGHMNpT/LY3+VnjcJ3ikqYPxFJ8XKIAMfI+tyP4ARJ6k5quZWVvstELQ+tEBxA39kjvjsb3OGH8JTkzyozuRzJGLB9Jk6t2nv1gt3KQzex+zUQ6MYjctcYjGj30dAz8HphHwD5x7XVHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=HROX0Txe; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E78AF40424
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1739641691; bh=4Y52jyR3ucaHhw63Dp593fQs7wz+3M1mpqIkYiIYS6M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HROX0TxeA+L9kIchDCp7QuosgfgBTUwCRrJnwD1r75WTa0rmTW5nPuQeUBTiXSZvK
	 8nciZRdxRlq2nvYctlTAEdzUheaEKS18qdJfsbEkHKMAKpri4kfZQsfuNcXTRS39Ba
	 edoYLUmj7NEHIOhYkzLMlb6ESXKVlrw9Ir35q9/2yQDsu1j0Lclbx/SYj5KdbFtcsC
	 abkUJSGTAUCOxYt9MdBhM3r/RGYieWEjqudTP+cL3G9jSLHxdhvq+YncyCsROPFuu0
	 Fn952ffKNOXl+4maGkARlvqt7evZjQkInjTfowTFyNjSzgD0kgAO/BjOEjtCiqZqpZ
	 Dmv0qroMcw0Qg==
Received: from localhost (unknown [IPv6:2601:280:4600:2d7f::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E78AF40424;
	Sat, 15 Feb 2025 17:48:10 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Suchit K <suchitkarunakaran@gmail.com>
Cc: akpm@linux-foundation.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] Documentation/mm: Fix spelling mistake
In-Reply-To: <CAO9wTFiUW42yKGaZDQD=CR5f2pmjLNQfJcd81+gargstGVrF8g@mail.gmail.com>
References: <CAO9wTFiZ8wyangitV6RZLYiL5yF5CV1eRXYYzJKhXyP2UvGDJQ@mail.gmail.com>
 <87tt8vunmv.fsf@trenco.lwn.net>
 <CAO9wTFiUW42yKGaZDQD=CR5f2pmjLNQfJcd81+gargstGVrF8g@mail.gmail.com>
Date: Sat, 15 Feb 2025 10:48:10 -0700
Message-ID: <87ldu7umjp.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Suchit K <suchitkarunakaran@gmail.com> writes:

> Hi Jon. Thanks for the suggestions. I initially sent HTML content so
> it was rejected and had to send it in plain text again.

When you resend, please always say why.  Meanwhile, though, you have not
yet succeeded in sending plain-text-only email.

Thanks,

jon

