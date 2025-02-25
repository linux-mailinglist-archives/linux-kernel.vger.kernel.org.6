Return-Path: <linux-kernel+bounces-530335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FC2A4322E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 02:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73F4818910C5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 01:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003B8184E;
	Tue, 25 Feb 2025 01:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Su3LiG+0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC9C2571CD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740445210; cv=none; b=tS3bR60W3+t+7ZePfdfLhP7LMYUShA5hjFCurt0jSEEsX4DpSZSiHxnt68vvS/ZJ9y+H+OCZEBaAcIpCeUO1o06315JdWBier4WiaPe+N0RUblePb50rLBpZNb43EdYyvStV67LlJJqQmdq7PnNh3Ks4GaPzhp23gXYT/Mhls8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740445210; c=relaxed/simple;
	bh=CqOdkociJL6eQegTtNYNfyuksNq75DVWeTEz9rVLYkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMKyAeM6nG5WwaUHQ47EllXoLq7urX22Km/GQEN7niJCqEJifqFdLYT0xqB4IHw7MtQIqdo4CG3P2wZFAPUFBbf+3NUzusqM8vlNkijPXuF9nRBX/C795KDitz16xhMA1RVhjrRATSJsN++XSA+AIHfExCaMvxbWXE8NDiq0b+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Su3LiG+0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E545C4CED6;
	Tue, 25 Feb 2025 01:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740445209;
	bh=CqOdkociJL6eQegTtNYNfyuksNq75DVWeTEz9rVLYkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Su3LiG+0KR3U2LA34zTkYDXqhGPcTbo+Y7De5PZ4GWjhz1WsyiX5trUwwetnGfT8j
	 64+uJRZfH8+rYQUs+iTjYzuLrEB9BQv1K+R3rysuAufk9xFI9Xuamk++dIlHE7YJ8h
	 S5hVpRjzD369VL3l3a6MED36QTEGs/3X+Wn5AMJsQFZlsRoXD7hTlLHZt6/ad+hQLc
	 XoRhtg7sZu+2tIxBXNk4oT3DhGBsicEkN6wentRSXCkVXA3bSaM/UH4FHZ65WoZEMa
	 rbSuMRJTN3GCJHG2d0OzX9b/mo66VSbHdt/J6Ppw4fmZxfDZpszuYmp8z6bdKOBgHX
	 YIw5qlJ/RD30w==
Date: Tue, 25 Feb 2025 01:00:06 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Joel Granados <joel.granados@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reboot: hide unused hw_protection_attr
Message-ID: <Z70WFl8rOrZ9XCWV@google.com>
References: <20250224141849.1546019-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224141849.1546019-1-arnd@kernel.org>

On Mon, Feb 24, 2025 at 03:16:09PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The reference to hw_protection_attr is inside of an #ifdef block,
> but the definition is not:
> 
> kernel/reboot.c:1092:30: error: unused variable 'hw_protection_attr' [-Werror,-Wunused-variable]
>  1092 | static struct kobj_attribute hw_protection_attr = __ATTR_RW(hw_protection);
>       |                              ^~~~~~~~~~~~~~~~~~
> 
> Add another #ifdef to match the first.
> 
> Fixes: 6f0ec17b2d82 ("reboot: add support for configuring emergency hardware protection action")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

