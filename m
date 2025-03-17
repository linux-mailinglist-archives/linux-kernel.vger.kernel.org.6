Return-Path: <linux-kernel+bounces-564375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EEBA653BA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B77C18904BA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5568D24290A;
	Mon, 17 Mar 2025 14:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="JwK3y7t6"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6322417E5
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 14:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742222166; cv=none; b=nB8b8VXiKXl/iCyrmtWmbaHm1sBfYdiekUJqO3Y5BMI3c30Lrfg6jUa+3yOjM1eMGbubS92U0JW91cLSD3Ceo6s0+Iy5bSDgMLRYc1g/l7nFnvAJeoAoVkSZ8s6zjhm0IV/m/l3I94WzZcEK0hRvY1TfE5UoWt/oYQ6hjH1bSwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742222166; c=relaxed/simple;
	bh=75LOFLkQeS2D990Jln8z6W9YpYFlu6vf8JAndacVpVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KmlbqV/CIZ0xenRjRG2roLSeWBVyI9fthcUsSlqfJgR3wpL6qAfwVnbCMY23s/aNFKgbQkNuWOWXyXCnJ5PEoZsIRWeqI5EnCqEiSJSZ9jOxgSXVdVDT4JW9lDWmpI6iaw1U9CLXYbJP7r8kyt+9K5mKGYYOJBOPn4mXhmLNlmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=JwK3y7t6; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=COKOBF5Kp6/L59jrNmNEgGlDWvJC3j7petKc4gxeZ0w=; b=JwK3y7t62997PvSrOTPsG0zOxW
	LHc2KgGu5yt9ZAkii/OyEV2QTaClAzsCAX0pX4hDhTrgx/qa8cimgJzkUfa8Ji5Xl+DDijY4wtqwq
	I71UUM3zUEBC2ddI/MS9dUy2nQktJJYmZa1nK3jDQZV6CDvCl7tMpVwPPVZ5Rpam8ZaKixxvINhRi
	C+bM+KN/Rvlfm9APHfw3nMju7dxBsn0zon5g/mCr0tGkSCn7UwoLNtkZYBeZpbcPW9KF6DZT3EsW4
	V3uqE07hMSHe9A6+SZcqHfZmeaZ39dmo/wX6QehIuTI+7HrrWH+5UNvKuE/YG74lGARe+j4fPW6wV
	HlUPRmTA==;
Received: from [187.90.172.172] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tuBZI-002Gaa-CC; Mon, 17 Mar 2025 15:35:52 +0100
Message-ID: <1238b1d0-275c-9117-a2e3-5e7684404980@igalia.com>
Date: Mon, 17 Mar 2025 11:35:45 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86/tsc: Add debugfs entry to mark TSC as unstable after
 boot
Content-Language: en-US
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, kernel@gpiccoli.net,
 kernel-dev@igalia.com
References: <20250226132733.58327-1-gpiccoli@igalia.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20250226132733.58327-1-gpiccoli@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/02/2025 10:27, Guilherme G. Piccoli wrote:
> Right now, we can force the TSC to be marked as unstable through
> boot parameter. There are debug / test cases though in which would
> be preferable to simulate the clocksource watchdog behavior, i.e.,
> marking TSC as unstable during the system run. Some paths might
> change, for example: the tracing clock is auto switched to global
> if TSC is marked as unstable on boot, but it could remain local if
> TSC gets marked as unstable after tracing initialization.
> 
> Hence, the proposal here is to have a simple debugfs file that
> gets TSC marked as unstable when written.
> 
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
>  arch/x86/kernel/tsc.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

Hi folks, gentle ping about this one - any suggestions?
Cheers,


Guilherme

