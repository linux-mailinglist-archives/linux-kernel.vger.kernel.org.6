Return-Path: <linux-kernel+bounces-344074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D093398A3D9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E21D1F283EF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB0118E76D;
	Mon, 30 Sep 2024 13:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FB8+2eEI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85AA18E346;
	Mon, 30 Sep 2024 13:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727701261; cv=none; b=lfAG8vZCUegRt1pOv8ebs/FSMel21geXP1US+ucUnYXHNoOTxr71LSoQdmf2MD8cmvbmSshfwBxna/fXh2o9zd1+tNGIxkFpSLf3MvYZMsrCrzovooSq+7OU2TgMZf/CknK9xlP+BJoo7V/GvUsYk+9o9u1MhYflB0yw73ux008=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727701261; c=relaxed/simple;
	bh=MYtdHPBH9D0toFpQLKEM+x4oOnqFVTkl+BJ11BF5efA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9dwuHvWDQE4bXZnX29BRmjKyblxmQ3HbRuXlsjYmRnNIpfdqdun5DUeWGAO/eust5yFkCjVaormF02W8yhE8eITNsHDciFbxpt0QmYVxN2psuCb5lYn2ETKRxIecIfOZ/ZtjqdmIDzzW+0jkExAcv7c8bqtv6EZFa+kgQcMJQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FB8+2eEI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8A4C4CED1;
	Mon, 30 Sep 2024 13:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727701260;
	bh=MYtdHPBH9D0toFpQLKEM+x4oOnqFVTkl+BJ11BF5efA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FB8+2eEIzpFGAVkJ1vHsZ/fQ5CSfrD2v0kbRtjMMXcBEohNII7KKWtv8WmGoON9Lm
	 NByAomWVIbDhDPEgc45k+tIXi+vrduAV8ppL6EWHhnIotwo0axVyashf09FXx67pnz
	 sGgB9euEh4VpoEN/QU2JZgJZPsHDJZgXBoaIq5bY=
Date: Mon, 30 Sep 2024 15:00:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Cc: rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, aliceryhl@google.com, mcgrof@kernel.org,
	russ.weight@linux.dev, dakr@redhat.com, a.hindborg@kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] device: rust: change the name function
Message-ID: <2024093014-endnote-swapping-6626@gregkh>
References: <20240930123957.49181-1-trintaeoitogc@gmail.com>
 <20240930123957.49181-2-trintaeoitogc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930123957.49181-2-trintaeoitogc@gmail.com>

On Mon, Sep 30, 2024 at 09:39:56AM -0300, Guilherme Giacomo Simoes wrote:
> This function increment the refcount by this command "bindings::get_device(prt)".
> This can be confuse becuase, the function Arc::from_raw() from standard library, don't increment the refcount.
> Then, this function "Device::from_raw()" will be renamed for don't make confusing in the future.

Your editor should have asked you to wrap these at 72 columns, can you
please do that?

> 
> Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
> ---
>  rust/kernel/device.rs   | 2 +-
>  rust/kernel/firmware.rs | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

What changed from v1?  That should go under the --- line.

thanks,

greg k-h

