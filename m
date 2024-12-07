Return-Path: <linux-kernel+bounces-435934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B4E9E7EC6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 08:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ADB218864CB
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 07:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1FD12E1CD;
	Sat,  7 Dec 2024 07:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBVpAJuF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B6922C6E3;
	Sat,  7 Dec 2024 07:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733557730; cv=none; b=EjkwxkpNS2cfGr505Q8bXjHtPy2RG49KDwhQnFX63NZ2jZabiCh3LYKiRhkxDZZRKEC+APimUGVI94B4lto/dvGIJeqhlrVXZipIN/0omYOw58VNZLHhl0KU4QRtqaT9CUlXsVUgv19Rb1ZzzFRnYgepvWO3HpameVIqYgY6Qmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733557730; c=relaxed/simple;
	bh=nK8CMR0YxF51ehlzgoM1dSovN3Kl757xlaMNFy3fDyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k66LkmpZ9FvUMSsZnP5O27x+KIG/S2EoWpTKyx85NEZ3TdUlXxtbgQXwyDh4V0EXNamIVGkfbNdxaKRbBYjwaYDJwGSQ09Uj6l0cYnvi5lpuxB+iIO9StanWS47kMgViI6fyS4uk+PDaG+AwrEuDkqNuP/XZ/kOQ9hfDX6dWWUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBVpAJuF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D8CC4CECD;
	Sat,  7 Dec 2024 07:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733557730;
	bh=nK8CMR0YxF51ehlzgoM1dSovN3Kl757xlaMNFy3fDyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MBVpAJuFjhJSF5zdIl3wZSkC4zAAeL0YYMYUkdvC7pC3aLGQVRm9Uz6LusuO+dzOg
	 oOQ0OcOwc4aA/Z2WeV17Oe/1Z9HKyHGsaaFQlN9u3uMbPO6NXSeowW1u102QAg9UAa
	 UZzOoFPx17pfd9DTsEOotJA+LLAnJHhTnc9/uLParczlJxXbNnUiYaeri+riFXMMkq
	 RspbpaYubO4AYxN46wHO9ufCmOM2tpFsqBsDSuPNsa/cjz8e+Fj8UB/X+BGI2DCRuE
	 ygdItvBgrRykv5lRHiRfioFPVeAcCt0dWjNTsdkoTCPFMPx2inqPIdbsa3cS1eBjyL
	 6OrkRRmiDsqLw==
Date: Sat, 7 Dec 2024 07:48:48 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] hv: hyperv.h: Annotate vmbus_channel_gpadl_header with
 __counted_by()
Message-ID: <Z1P94CdlCAzDc3d3@liuwe-devbox-debian-v2>
References: <20241015101829.94876-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015101829.94876-2-thorsten.blum@linux.dev>

On Tue, Oct 15, 2024 at 12:18:29PM +0200, Thorsten Blum wrote:
> Add the __counted_by compiler attribute to the flexible array member
> range to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Compile-tested only.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Applied to hyperv-fixes. Thanks.

