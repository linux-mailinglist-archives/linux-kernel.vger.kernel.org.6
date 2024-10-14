Return-Path: <linux-kernel+bounces-364734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF77299D899
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 22:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86B8BB21DB9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 20:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627B61D31AA;
	Mon, 14 Oct 2024 20:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+j7SIyJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D5A1D14E1
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 20:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939275; cv=none; b=fY8XpDpObNjkfJzwSWZs1GQEsYBcgaDcwQTfVQr/DHr0BjeiJvsIczRbRsFy5HC7cG6D73/JHGnDTQyMug/9CBur3LtqYMd+YKAMdVpzDLfJy3QRaghRqBDFQUPFJSMKQIPixYU3p03kdWKbgWUpdYIJjwR30d+R8XO03VPweSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939275; c=relaxed/simple;
	bh=lPrerADCuriCIw1uM+h2A0ONUGJN8Rfcxz6aH9C+9yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqHCRis6RGNgYZmsvCYrZJT5uPYj4gg5mwZ6nSOLRmaiYyN9tuaC+KU+feiwAEa6/PJaVrmxIe6lnULAsFU5XdR/jz1KFw/uF2gvu6/09F/vDogXORkeHg98ZZ8idSL1Wrzsu85Fsu6Y3T4GyjUuQnK1gwovLcq0K3UTeA3TdJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+j7SIyJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57081C4CEC6;
	Mon, 14 Oct 2024 20:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728939275;
	bh=lPrerADCuriCIw1uM+h2A0ONUGJN8Rfcxz6aH9C+9yo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J+j7SIyJW2WNhK9bhxm0uUp2sXMGYgfJpVB1pbn0FSHSNZ6a5jN173gGDZCG2XcbF
	 +6FtWMDq47m7I08n8+t8BEkagvYdIHOEkZm9vLIdKHH9zxDP3w4GRNt4v+xoQBTn/w
	 SS4VU2FbwpHibYb3Pr90878sAuPKu2ra5ieHs8JbOUnyEHCc8ML+GHrxJ8VTCV/Fjj
	 jLwRjW2Bqi+bjd3CG1V9t4uNhFsamwW9J0TAIZEtn2EAWzY8pE583gqcLuIQF1GWAr
	 3RYpdEn0IAfRZf7lRb5ZdazqaJ7UDxCyAPB5yKY6ZgLdrUwR55iBhfx7vLFq0R19zV
	 yQjT/8vscaZXw==
Date: Mon, 14 Oct 2024 13:54:32 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seccomp: Stub for !HAVE_ARCH_SECCOMP_FILTER
Message-ID: <202410141352.7C2783E@keescook>
References: <20241008-seccomp-compile-error-v1-1-f87de4007095@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008-seccomp-compile-error-v1-1-f87de4007095@linaro.org>

On Tue, Oct 08, 2024 at 10:29:43AM +0200, Linus Walleij wrote:
> If we have CONFIG_SECCOMP but not CONFIG_HAVE_ARCH_SECCOMP_FILTER
> we get a compilation error:
> [...]
> +static inline int __secure_computing(const struct seccomp_data *sd) { return 0; }

I don't think this is the right solution (for gaining ARM generic
syscall support). For example see how this is done currently on ARM:

#ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
        if (secure_computing() == -1)
                return -1;
#else
        /* XXX: remove this once OABI gets fixed */
        secure_computing_strict(syscall_get_nr(current, regs));
#endif

If we just return 0, all of seccomp will get ignored. I think the
generic code needs to do something like the above...

-- 
Kees Cook

