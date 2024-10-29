Return-Path: <linux-kernel+bounces-387336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E67F9B4FA0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297D71F23075
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DF01D2F73;
	Tue, 29 Oct 2024 16:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXSKCl3z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D427F1CD2B;
	Tue, 29 Oct 2024 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730220152; cv=none; b=FboTpY4KCydJokeV1OGj0MrzIIW6VPRF8tMNvYwzgvD+xrb2NEZNM2hqsel1nksUwruYg4Zz46q68ykL8rqnakgaGzqVf7osIdWuuWo5OPLDU2W6XMMHnQ3HpRqG3TQMC/DM4OAlJsyu+bw9lfm+Dzy89Y1yuCxyVTBHGpvwSvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730220152; c=relaxed/simple;
	bh=WJdvCjdczhSYGcDEEVPkxjXD+WbIuzwPwk1S7xXiHyo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g+wVKEDzfbT4yplYtJPW3vBKUPol0FMXETBVPf7kYZDujsPYpeRRH5LB7zpGG5Q06eFMgI3v0UfitZ1jSKfchyeKn8Aydv1PFuAtcj/4hE3/RkkYJJJKYQZUzHiWzncO2XfhH52/vbboN8s+kdYBbmuWktbg8Iv2HEPNmQuX0+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXSKCl3z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478DCC4CECD;
	Tue, 29 Oct 2024 16:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730220151;
	bh=WJdvCjdczhSYGcDEEVPkxjXD+WbIuzwPwk1S7xXiHyo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZXSKCl3zgeiOFb5Vx6oYOGYyrbBaxHOol4SkpsvwkzdBj7mHyF/9o1YbC+ZMdgRLt
	 bdEILBvCTZVTZ+TvuKftTOxhGzUDLvJjIjFRUkyDOKFIN1l8+av4AcgnOFybZ1y+ig
	 1ku1hXSDhC8EFzExBrDbR0X6xonCJMl0c26Ai4spgwQRgFvqeaXo95AOy8EiglBblG
	 P6/yuDR6+Rph41w7XUliHAircNw3/L+4VJdo2+cSpBCY18lmEPvFKpQ8qOhOgw6eeh
	 XnkWXnovNawD2qEcZl2O55YgL3pmcLdWdyZUXQMeouBU+wVPqCehsqQy58b3oxB4YJ
	 uPTa7ydjBxZyA==
Date: Tue, 29 Oct 2024 09:42:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Dr. David
 Alan Gilbert" <linux@treblig.org>
Subject: Re: [PATCH] MAINTAINERS: exclude net/ceph from networking
Message-ID: <20241029094230.55048a67@kernel.org>
In-Reply-To: <20241027202556.1621268-1-idryomov@gmail.com>
References: <20241027202556.1621268-1-idryomov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Oct 2024 21:25:55 +0100 Ilya Dryomov wrote:
> net/ceph (libceph) patches have always gone through the Ceph tree.
> Avoid CCing netdev in addition to ceph-devel list.
> 
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

Acked-by: Jakub Kicinski <kuba@kernel.org>

Thanks!

