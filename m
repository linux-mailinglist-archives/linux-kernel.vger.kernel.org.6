Return-Path: <linux-kernel+bounces-515245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B622A36248
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2294018969F2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F0425A2C2;
	Fri, 14 Feb 2025 15:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="ZpTxk50c"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D0B3234;
	Fri, 14 Feb 2025 15:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548226; cv=none; b=JIXAWlLRC0vzpWttDZdu59DT1kx0qF5u2f7OWSP66I9tia5mlCsyzbHMOfxUrl5UyOMzSxfZVKUlkwlcgHtCD1KoAJnB4tIHJU+AGCAO9ExH1M0TOZcJjVugIytBK6LTdvhth02+BlweM6jmHiqCy1qLe+RK6NM5t6Cn4xuj6q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548226; c=relaxed/simple;
	bh=d87Fp29SX/9mo7DW1IDuBePsRsIHajFmkTP3ciRcnsA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J0qak+cTiDOAsw1zS+wjTTgn6w7GwP+t2oZZxnhrW9rH/9jim7HalQaI4V/xdpfkK2mIK9PBP4EpM4lxkUJ+X2A/5GkN26Q1Sbopt3iYgTyfNVYHbOWj9YacDscDX5JzUfWS0pa/PvQz1AKfHua+c15ws2YB3+6k3gbgBLNrskA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=ZpTxk50c; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9872544097
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1739548223; bh=Rw3XqFfqBcidsh18SER/4ZRj7Gv4YvSYLr57gTq6oik=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ZpTxk50cEKfJWBv9K+aTcDfEdBdTtNlzzZTbK/RT9JyHxd6praoiNMrG9odf0zo8u
	 dkirFXeW/msx2iEFn6xbttdWZPRFw7rQ7gzOIKg0S9UdhJ5/6TbZRUm5RXYKL6maDq
	 zCoWTKob5yXS2jYHsjVLZ5m0abmBQY9OTBiSZbb4yaUk8PiMMnS9FLd4HSgfP8ia6Q
	 zDDmAt/dMv+RDnN1a5FPdLZ/pBzgO2WR00z+IB1JgSB3/Rt+WPNgW22mnMSrbT+U1X
	 FVgbMhUbzLRxGMuBRtFf63elTN2bIPQH6VTdFS+k4lgTU4ah3c3CxUMprl1809HQg3
	 P3wVSgfKvdccw==
Received: from localhost (unknown [IPv6:2601:280:4600:2d7f::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 9872544097;
	Fri, 14 Feb 2025 15:50:23 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dongliang Mu <mudongliangabcd@gmail.com>, Alex Shi <seakeel@gmail.com>
Cc: Yanteng Si <si.yanteng@linux.dev>, alexs@kernel.org, Yanteng Si
 <siyanteng@loongson.cn>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] docs/zh_CN: add few request for Chinese translation
In-Reply-To: <CAD-N9QXRjr3yVtyucRbRJqXcJy0JwR=UhcNoHPbs3MQ2JcGKdg@mail.gmail.com>
References: <20250213054222.21776-1-alexs@kernel.org>
 <20250213054222.21776-2-alexs@kernel.org>
 <5d35c3f6-a52f-4e63-a972-50ee2898947e@linux.dev>
 <CAD-N9QXhmNBUFPfo11-h0H0Du_JFNX_Qxcs8aoesW8=ABgneaw@mail.gmail.com>
 <CAJy-AmmZAuZWUS5TTuSGg5y33Q7Q52CGQ7en5vg_eB2W2y_s9Q@mail.gmail.com>
 <CAD-N9QXRjr3yVtyucRbRJqXcJy0JwR=UhcNoHPbs3MQ2JcGKdg@mail.gmail.com>
Date: Fri, 14 Feb 2025 08:50:22 -0700
Message-ID: <87bjv4zfsx.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dongliang Mu <mudongliangabcd@gmail.com> writes:

> It takes quite a bit of time to finish running `make htmldocs`. Grab a
> coffee and relax while you wait!

If you have not updated to latest Sphinx (8.1.3, say), you should do so.
The Sphinx developers fixed a big performance problem, and it's much
faster.  Not as much relaxation possible as once was...:)

jon

