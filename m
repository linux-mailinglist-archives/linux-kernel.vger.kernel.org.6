Return-Path: <linux-kernel+bounces-187700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFC98CD6D0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 17:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48FBA282F9E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA85134C4;
	Thu, 23 May 2024 15:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sr4xJgCi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D093912B89
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716477251; cv=none; b=kfuvDdAk3UPhqXfIPaaq5bKO0NootybMGUJOgWKN6wyixV3TqwS4djLC/CQDQeLgU4UoQ15tbHK4NURiIO9h4m80hldTFp08aknBgidtcLVBBp34nYY1yXGAsLJj7NbOPIc/jnPQ3EOyY2Y80G/u3Pkf43fW4SoWQsHArw5lw4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716477251; c=relaxed/simple;
	bh=Vq+DWUYvIUa7nKt0+yu0jxW7M44ybWNMUxg1/1Uy32s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VE18+/ZOMmQmnU0riKTtg2dgBbbZkJLOfB1cgYzVbviG9DeByRIVNse9cD57nLh9nhnJME2XwHP+kjncgPipF7G7c6dTaHno31o67spQu4y9EG8nZQqDjPJ0GLu4Fz7tJ+qqopdRReAkK2RG4er96VOkRB6SjieCwtnyBDDtWYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sr4xJgCi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC2FC4AF0D;
	Thu, 23 May 2024 15:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716477251;
	bh=Vq+DWUYvIUa7nKt0+yu0jxW7M44ybWNMUxg1/1Uy32s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sr4xJgCiafNKKeBT+yyrVeEkeife400RT77DlPzqcXtlkD5O3M64ohC/e8x3V6kVo
	 ZzrS3MztBNUkuNRNTULRj2+kJKdBeCs/mMWDRFwejGNBoD6HI5brag34HNfYnnckgp
	 0EJUt+uE+7WNtiB2FhG3vOQl9IRzar6UbfEZEtJbEtvU3wg/4nyS0RopT5qS9Ir75o
	 kn8gUva+6upf4LHYxUUtjCl22EZEUz1L/luYS8VrQJt99PuRo2Xu2kzXW9veIndibu
	 eDPXzgO1w7IqpLE4m29YuHVOen03ipzTLuD2a0Oqnjf9gEkdAeIH2jaEQRGm7emLA4
	 0H+W7PkhmE9xg==
Date: Thu, 23 May 2024 08:14:09 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	the arch/x86 maintainers <x86@kernel.org>,
	"H.J. Lu" <hjl.tools@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [GIT PULL] x86/shstk change for v6.10
Message-ID: <20240523151409.GA3299521@thelio-3990X>
References: <ZkHLrqO1HdfQb71Z@gmail.com>
 <CAHk-=wiAXOLja2AqBzPZE+k9DKX0wjBGKZT+m2DN_hariyA0Pw@mail.gmail.com>
 <ZkRtRcaqO+4jy3QW@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkRtRcaqO+4jy3QW@gmail.com>

On Wed, May 15, 2024 at 10:07:33AM +0200, Ingo Molnar wrote:
> H.J: *which* are those OSs? I don't think any major Linux distro enables 
> x32 anymore - here's Ubuntu and Fedora for example:
> 
>   kepler:~/tip> grep X32 /boot/config-6.5.0-35-generic 
>   # CONFIG_X86_X32_ABI is not set
> 
> 
>   kepler:~/s/fedora> grep X32 lib/modules/6.9.0-64.fc41.x86_64/config
>   # CONFIG_X86_X32_ABI is not set

For what it's worth, Arch Linux just turned it back on at a user's
request:

https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/commit/b0c9bf78acbdcdf90405c427cf6b751259baee74

https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issues/51

Cheers,
Nathan

