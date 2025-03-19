Return-Path: <linux-kernel+bounces-567846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF095A68B17
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 610B0162BAD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF87254AE8;
	Wed, 19 Mar 2025 11:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dp6M4tu/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF7C253B48;
	Wed, 19 Mar 2025 11:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382275; cv=none; b=CjL0C2FqOonZ5jXd1geF/i3SmbuhMXfEdqa0CKbpVZsnRNiPkla0JcNkSzhbTCTXiC/MGoH40KCdvCgJPFlKWg/vdcJJSyC/jboFEAFHQvdMC+hu3tdKH7j7clDGcBbZycWyPA5Q3z6YHsTBw/d3jvBOe0xmAgVDbWZx2T2+1P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382275; c=relaxed/simple;
	bh=UpiMmmMfB/MDr7vxb3W6l/P+ytPlb9GDBWaa+pQ7gPA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IiP/m/VRfIu7FEzPwSx4+6D6NmZ29UslJJUETB+gq/Q3hOXSj7slSexCSJUpPkkOZOJNCEXgUvSqXPo7Er6xnl12L2EJs0/BJgVH6DcBRjMElfsZhzJmriVS6dlJEexxHTj7EdTnMztm3oDc5PXBcQf42m1IiAfxAjRO3P+HsYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dp6M4tu/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E83C4CEE9;
	Wed, 19 Mar 2025 11:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742382273;
	bh=UpiMmmMfB/MDr7vxb3W6l/P+ytPlb9GDBWaa+pQ7gPA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Dp6M4tu/wdkMafn4IKE5uj2NHEorp8xW5uEWxTExBIlpK1IGJcjbXf+hKNvTuYyUQ
	 o6xQtZYYI6A8vtqD0BKbw1MqvqJDCNpjDM53jZVwlGJ4NqztotKqAa3IOrO/SLlNSM
	 8pwxcC7FwL8GheOFIAmlstC7kmu0O6B2h4JE5X5928PN55GpPD8VP53djaRdNjI9uM
	 FuL16c+jvp89MdnO4cPER+sRqqMFCKtY9q4kO55buMpcvnAv085ZcQa4cQHRw5TaYd
	 luyFUCOppmmszXa/SlhSVo4RgsvqhDSHjct5FsYC+yMuuMpMqsP4DhyaBdQYcNNV/H
	 lLiaoLwkmKB0Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "chentaotao" <chentaotao@didiglobal.com>
Cc: <boqun.feng@gmail.com>,  <bjorn3_gh@protonmail.com>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <chentao325@qq.com>
Subject: Re: [PATCH] rust: block: Remove unnecessary comma in introduction
In-Reply-To: <20250319104412.50625-1-chentaotao@didiglobal.com>
	(chentaotao@didiglobal.com's message of "Wed, 19 Mar 2025 18:44:12 +0800")
References: <j2rsp4Jty5pW-HOPkZX9ssG_ESGp1SAlh--rbhrhTQ6Z81f-tRt5SjBx42XS9jZo2vytk_ry-q4RYXMSD6B9xg==@protonmail.internalid>
	<20250319104412.50625-1-chentaotao@didiglobal.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 19 Mar 2025 12:04:25 +0100
Message-ID: <8734f9i8na.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"chentaotao" <chentaotao@didiglobal.com> writes:

> The comma after "methods" was not needed and has been removed for
> better readability and correctness.
>
> Signed-off-by: chentaotao <chentaotao@didiglobal.com>
> ---
>  rust/kernel/block/mq.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
> index fb0f393c1..ee8f34f40 100644
> --- a/rust/kernel/block/mq.rs
> +++ b/rust/kernel/block/mq.rs
> @@ -23,7 +23,7 @@
>  //! IO requests are passed to the driver as [`kernel::types::ARef<Request>`]
>  //! instances. The `Request` type is a wrapper around the C `struct request`.
>  //! The driver must mark end of processing by calling one of the
> -//! `Request::end`, methods. Failure to do so can lead to deadlock or timeout
> +//! `Request::end` methods. Failure to do so can lead to deadlock or timeout
>  //! errors. Please note that the C function `blk_mq_start_request` is implicitly
>  //! called when the request is queued with the driver.
>  //!


Acked-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



