Return-Path: <linux-kernel+bounces-404043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A3C9C3E71
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 13:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BF95B20B4C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9212B189B83;
	Mon, 11 Nov 2024 12:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQ+X4Ign"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E4514A62B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 12:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731328349; cv=none; b=qvbp3SyAnn++JJWvElJK51a1bEIGoPZ4dweSW596cFDmp1v42i+AJlaAzkv6xbIHWTXjipoOiS/XMup83NqHO0CtRAkPB1ihnPYGRbk1bcMz5eN1RanZXeEyFw8i2r2lv8esjUpdaojoTgUNPeedC+/mexWSpjvAZ0TcB9yhvbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731328349; c=relaxed/simple;
	bh=qJFsUKLB+VlCacWxJDjHF7hPr+qkb1rldQQArNwBxpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JaF5tfd801uiPZJRZZiylPty3Ni8Bi2/aKd3eNTCu2B7vqIcANZfuVpVvR+69a+xJjxuVYqRxw2aTLxkPgz8pGASBIpasZEJlu8pD0WE8K9el/6SUOEn4UuCkVBcKV5faBh5qpPYWFWeejPKb2Ltwi5j1IXZMj2+P06VOV5RVQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQ+X4Ign; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645DBC4CECF;
	Mon, 11 Nov 2024 12:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731328348;
	bh=qJFsUKLB+VlCacWxJDjHF7hPr+qkb1rldQQArNwBxpQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qQ+X4IgncLAfyVgd8QqtL36wttpSJ+j4xPYJb+IAnWiNvtJsiFedWk5GrI4qHGgA3
	 uCwfCWNltvBn43b1IJnJWVXvReSm/B1TxXqjeOK8F2W3m6O1QdRqKpAqEBdJQ9Kcxj
	 5P8Qsu0skm4phUl/qZKsK7enAAS+Rk+lawIZGgH7SAdACAEvKzRZ5yyqbDZJCk6CfW
	 pX2QVplaLqivfDXdmqwWhsSz2c1yb3wiyI8ne6JHB3nhlmp78gs17D2f4m2fWQaf/V
	 Vf0j1mUzRLdWAxAvxZ+d2Wju/zMe/FWPbbRYENWxnqGxKTorswPyGvrASzOYh5gqGi
	 U5aAaesbrmkUQ==
Message-ID: <5324102e-b2f3-4b39-8861-da9ebb78ad40@kernel.org>
Date: Mon, 11 Nov 2024 14:32:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] soc: ti: pruss: remove misplaced semicolon from
 pruss_cfg_xfr_enable
To: guanjing <guanjing@cmss.chinamobile.com>, s-anna@ti.com, nm@ti.com,
 horms@kernel.org, p-mohan@ti.com
Cc: linux-kernel@vger.kernel.org
References: <20241109032631.258765-1-guanjing@cmss.chinamobile.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241109032631.258765-1-guanjing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 09/11/2024 05:26, guanjing wrote:
> Remove misplaced colon in inline variant of pruss_cfg_xfr_enable()

s/colon/semicolon

> which results in a syntax error when the code is compiled without
> CONFIG_TI_PRUSS.
> 
> Fixes: 0211cc1e4fbb ("soc: ti: pruss: Add helper functions to set GPI mode, MII_RT_event and XFR")
> Signed-off-by: guanjing <guanjing@cmss.chinamobile.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

