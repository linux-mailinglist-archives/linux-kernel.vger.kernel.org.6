Return-Path: <linux-kernel+bounces-175021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF24B8C1933
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D5291F216E8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB52129A74;
	Thu,  9 May 2024 22:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjhUH6CD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFED770E1;
	Thu,  9 May 2024 22:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715292439; cv=none; b=WMtpyYem6+9wgCEs0+FpSNVRsvTn7RJz1qfMWK/kGjqLM10IOylm/yjMlMbp34P28JJIx9t6wiIDZHHWcF8vucQnaUhMeFVhf5hDgHgsoqXYgurwH/5wwvLMQDO5LfF72VhMzo2BLnBSdRfLbxaC8pbB6dOiQv9hBTYHi6/E+EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715292439; c=relaxed/simple;
	bh=z03sTgiRqqCI3iZ/uO7QrRfM0hacHjhvfowyj7A51KA=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=EuzNA3n0hUEQbI1y4t0HA5LCvIoEQnCo40qK1JS42H9Muvhk32nX7qnk/ZV4ipxYFotTNimrYzDogE39IjOf/o4XNcmj+uvjQtQQTLIvpjbcdHLU4TGNaVGRQ8gX8qTpcK+BsZbzDo6Iy7kYjOar9IYhL34cn/rKqHDutywG9dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjhUH6CD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35CCC116B1;
	Thu,  9 May 2024 22:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715292438;
	bh=z03sTgiRqqCI3iZ/uO7QrRfM0hacHjhvfowyj7A51KA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=hjhUH6CDQTzSuMxIJqISktliM+4b5RIDJHQ5z4Ii6lJFot+TQeBw/vMo/qxfGavDF
	 Zfs3JLQEru0PvxDNNvkREEs39TbQCgffJoqYJuSzeEzqFxNK8QVSeQN5zU7QVr40c9
	 +B3/K6/LGjWPWoQY6eyx5/01mGFYybMDqh2PDZWNc3Hr2/c+43hD4t3cXP2UUFg+5A
	 UwQBSQ07XNXCKgeenI9cu48MaXaTdecFC/t5aQSxxLR1sR9/UFcSKX3OIwV9jBvhx9
	 BugJ3+CxyqaJZjuATj4C5noZrIao5btIb44gsH6xb8guHMiEiInXP8IUJfoElTxgR1
	 T1pslNQ4YH+6w==
Message-ID: <a12ee2346ef9e00b6fca5dd4fce7de0d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240509001452.204929-1-linux@treblig.org>
References: <20240509001452.204929-1-linux@treblig.org>
Subject: Re: [PATCH] clk: sunxi: Remove unused struct 'gates_data'
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, Dr. David Alan Gilbert <linux@treblig.org>
To: emilio@elopez.com.ar, linux@treblig.org, mturquette@baylibre.com, wens@csie.org
Date: Thu, 09 May 2024 15:07:16 -0700
User-Agent: alot/0.10

Quoting linux@treblig.org (2024-05-08 17:14:52)
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>=20
> 'gates_data' (and it's associated define) are unused since
> Commit ee38b2698ae2 ("clk: sunxi: Add a simple gates driver").

Lowercase commit please.

