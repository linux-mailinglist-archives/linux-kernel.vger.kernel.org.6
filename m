Return-Path: <linux-kernel+bounces-526813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A311A403AC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 00:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96C2619C6C06
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D096253F38;
	Fri, 21 Feb 2025 23:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPT9Lg7O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C3B1B0406;
	Fri, 21 Feb 2025 23:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740181627; cv=none; b=f+W3YXiMxn+CLAMGmukAqpFEgeanXWb59Cptc1tA5K7+EsCQEzBNpPRpYpZi54/8uWdEl1oaQqP5iQqz9dYVF2MLGDPq+B45Jd8UeIcVPLRUbmjVBDXO7bmP7zTeB5bMx9xpLkfmBm7rhfuDJqHP6egAxyNrLKfnpUH4VxgYCFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740181627; c=relaxed/simple;
	bh=tvv3CVQ87XW6GTiJt4OIp9rEWjs0eLsUZyDUVJoleys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODc9R2Fqauh47YUh9MM76iU/qmRqMv55V5jieLKScyTHiF1PtV3Z9qoa8uqjiHdUJCdQnsae6C5lOicXitaiNoBZIHnNLcaYj+EqMcjtTioeCWSu/oLJ0NA8kVxqZjGYg2mPOEdGbnpNxy+3uSx82tr/mPN7s0Opaj/skSGA2Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPT9Lg7O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17777C4CED6;
	Fri, 21 Feb 2025 23:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740181627;
	bh=tvv3CVQ87XW6GTiJt4OIp9rEWjs0eLsUZyDUVJoleys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rPT9Lg7O1nzU+AvI+rBrmJmC8YEOt3H6HDVBh7HSkg5s3c+I2H03VUnESWMDbHzfP
	 nss6JXkrt7usdqa6fd+30ucvq8LQIe3J4+sf5sGF0nf8utwVRFcaIM6P4VR+HGq25H
	 wtAkPzjkM9KaKcZqrRKQXTqwKZeIMScjiU5jXqQKtHnxAzqXmh9rX3SsWLB7aoFlmD
	 zNWkvPRm0dJK4WfBiFE/SsL6E8yrp+3OmZlKCZJEabxnbYjWAfYVAlM4JLlejc9C3s
	 Endn+cfU+FrzRy/qPcTjyYLBg5ywdF9g6BVlUzMxpnpEkpJkL5NCtXR3ETikmxNlt0
	 CSudVOtPFFHPw==
Date: Fri, 21 Feb 2025 17:47:05 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Chen Wang <unicornxw@gmail.com>
Cc: fengchun.li@sophgo.com, paul.walmsley@sifive.com, inochiama@outlook.com,
	arnd@arndb.de, krzk+dt@kernel.org, tglx@linutronix.de,
	guoren@kernel.org, devicetree@vger.kernel.org,
	u.kleine-koenig@baylibre.com, palmer@dabbelt.com,
	xiaoguang.xing@sophgo.com, linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com, aou@eecs.berkeley.edu, conor+dt@kernel.org,
	unicorn_wang@outlook.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: interrupt-controller: Add Sophgo
 SG2042 MSI
Message-ID: <174018162492.399095.16752025893987256211.robh@kernel.org>
References: <cover.1740116190.git.unicorn_wang@outlook.com>
 <4967e01306c07908caebd60736f898579412765d.1740116190.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4967e01306c07908caebd60736f898579412765d.1740116190.git.unicorn_wang@outlook.com>


On Fri, 21 Feb 2025 13:49:58 +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Add binding for Sophgo SG2042 MSI controller.
> 
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  .../sophgo,sg2042-msi.yaml                    | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


