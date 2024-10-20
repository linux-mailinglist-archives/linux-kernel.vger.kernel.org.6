Return-Path: <linux-kernel+bounces-373137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AB09A52E1
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 08:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DB002835AC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 06:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D58515E97;
	Sun, 20 Oct 2024 06:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QzlDjAg6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF422FB2;
	Sun, 20 Oct 2024 06:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729405308; cv=none; b=aJHVjxo8CjMa/GTEXKpQuSkZYumq56afmxuBAHJdui55ZhzFntjAq1p9z5hRqGXb65OCslG2egWihkOeA4RZAbvbgfYhHoHaa5G7ZAtMTx2K8aEYJWcBgQNDgY/zIkCD6QTFURgtVBVUUJekWjwihwScTmmLTS+gu8HGLB4GSgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729405308; c=relaxed/simple;
	bh=e7xRo9gmhueeLOjCCKxAJGpcvRvhQjI8rltTlifZ1+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbPa/EiXUnNhw9vmx7PMJ3o2JeSm49rPkzhYsYxSH6ikZ+8xfBFuYVr7b4d8pUvIUoLTyJvJSy0faXaTsDpedBvSUB4G1VGp49TJ5ZD1roNIbc2O7CTuqZiKVyFMcgcKDQHN3c1ydDClJaZz3Kz8Y3giVDczYMEtJqYuns5NffA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QzlDjAg6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50149C4CEC6;
	Sun, 20 Oct 2024 06:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729405308;
	bh=e7xRo9gmhueeLOjCCKxAJGpcvRvhQjI8rltTlifZ1+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QzlDjAg68fhoOHL13QmA3c+PVqWW/APS1QFGL7zIIGtK6G3i4B+deiUjZO9xeaCIN
	 sC7skAuM2qNBWXUp4ZchhJoBW3lPnrfpiexxxfmy8X80tjQ2kJiagUEB+yj9YBWD9B
	 +hlDjLyrogovK+p7w306k6e7LLxsUIrf/Fs3Fp/Y=
Date: Sun, 20 Oct 2024 08:21:44 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guodong Xu <guodong@riscstar.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>, rafal@milecki.pl,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Michael Zhu <michael.zhu@starfivetech.com>,
	Drew Fustini <drew@beagleboard.org>,
	Alexandru Stan <ams@frame.work>, Daniel Schaefer <dhs@frame.work>,
	Sandie Cao <sandie.cao@deepcomputing.io>,
	Yuning Liang <yuning.liang@deepcomputing.io>,
	Huiming Qiu <huiming.qiu@deepcomputing.io>,
	Alex Elder <elder@riscstar.com>, linux@frame.work,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: vendor: add deepcomputing
Message-ID: <2024102029-populate-footage-755a@gregkh>
References: <20241019162605.308475-1-guodong@riscstar.com>
 <20241019162605.308475-2-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241019162605.308475-2-guodong@riscstar.com>

On Sun, Oct 20, 2024 at 12:26:03AM +0800, Guodong Xu wrote:
> From: Sandie Cao <sandie.cao@deepcomputing.io>
> 
> From: Sandie Cao <sandie.cao@deepcomputing.io>

Nit, for some reason this shows up twice, same for patch 2/3 :(


