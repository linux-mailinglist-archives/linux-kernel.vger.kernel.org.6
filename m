Return-Path: <linux-kernel+bounces-559534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D735A5F51C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 337F03BF734
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84F5267732;
	Thu, 13 Mar 2025 13:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4mGiUXD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515F5267717;
	Thu, 13 Mar 2025 13:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741870919; cv=none; b=uRCqsWRgi5qk1qzmIiBZxGzOwUXFtZl8QayseJJ/TVMtKvpgdMlopcCe+GfO52mkFYPeGdIgXaVMvW2ouji+NamOLrAkET9+SZ2H68+ZfHIuvscW3nwOhZTSb+lXKi8edB0xhMHlY/Ak5HB14FUuU7x5aboWRTNWLHQsKbxyW3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741870919; c=relaxed/simple;
	bh=qnJ0veSCFOWj9TUdAVLHnl9bnvjlXhzIeGXuDk0MMZM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WXHUoWifD3SexDUHAAQ9eZbU72QMgyuMNJbG0EmiTbZCkf1fFF/czTLUJZhFlClG2wg5glsHKz1nkPjnM43Uo4c7/SNu0a9+B/1Kah9nIdrHs+8LyJLq3QtwkxFZmie4XRcE6zeybZk9N7EsuNBtlQIlllTGMRW48jJ84SiAS3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4mGiUXD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22D1C4CEEF;
	Thu, 13 Mar 2025 13:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741870919;
	bh=qnJ0veSCFOWj9TUdAVLHnl9bnvjlXhzIeGXuDk0MMZM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=i4mGiUXDfM0rqmSSdZMWqaIAGOGYcj8csDy7wc4apsR7+hXLSNmu6vdsdZ1txxhIt
	 i9goWcbZ6VcoBXqG3KCPOrmDuggufZUa9aR2goG/Nqjwi0MawvtAZxceodasICp4T8
	 QD8wGn428XJJh9YW70LRoNIJhYBnL1vtBeqEBpsu1PfmtKllNT/GIFGGYDdYR7sM+k
	 H0U7t37u2rYFOmsH5hiKe8pi3+/cZ+e7o7gWkMErcCTLae2EnYFHg2enrL7BEC/dym
	 LpJfYmFAGphN/MHtCMM+PWc/ZSk9KHWXwSrDh7TlyyRsJWQfou0NK4ztNHhN9dnLc8
	 1UAq+zG+lfyuw==
From: Lee Jones <lee@kernel.org>
To: Lukas Bulwahn <lbulwahn@redhat.com>, Lee Jones <lee@kernel.org>, 
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Cc: kernel-janitors@vger.kernel.org, 
 Lukas Bulwahn <lukas.bulwahn@redhat.com>
In-Reply-To: <a15bb180-401d-49ad-a212-0c81d613fbc8@app.fastmail.com>
References: <20250303100055.372689-1-lukas.bulwahn@redhat.com>
 <a15bb180-401d-49ad-a212-0c81d613fbc8@app.fastmail.com>
Subject: Re: (subset) [PATCH] mfd: remove STA2x11 mfd driver
Message-Id: <174187091774.3628407.5991715723719010902.b4-ty@kernel.org>
Date: Thu, 13 Mar 2025 13:01:57 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-510f9

On Mon, 03 Mar 2025 11:17:22 +0100, Arnd Bergmann wrote:
> On Mon, Mar 3, 2025, at 11:00, Lukas Bulwahn wrote:
> > From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> >
> > With commit dcbb01fbb7ae ("x86/pci: Remove old STA2x11 support"), the mfd
> > driver for STA2x11 is not needed and cannot be built anymore.
> >
> > Remove the driver and its header file.
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> > ---
> 
> [...]

Applied, thanks!

[1/1] mfd: remove STA2x11 mfd driver
      commit: ba97b3e383c9c8a51afd6358efd120a0ece527cd

--
Lee Jones [李琼斯]


