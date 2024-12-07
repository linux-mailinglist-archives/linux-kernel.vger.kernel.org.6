Return-Path: <linux-kernel+bounces-435925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D083B9E7EAC
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 08:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A992C18843DC
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 07:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4B38289A;
	Sat,  7 Dec 2024 07:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzHUwpXn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E543B4C79;
	Sat,  7 Dec 2024 07:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733555899; cv=none; b=p/f5C3xJiZK6SsiRNedcLpNoCeHXBAje0GczS/qy8V5iy6+1vo0L9CxMrosF+J5qhw5x9YZwDGh2VouG0gTPBKMMNtGp3tjxN4BClJKnfHJvXu3ZdI3+4tjPSHgGZMLT4ZOT/QfEyVWjMkFkXMH+j8Rxg/1hGm44Atup9CvTV+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733555899; c=relaxed/simple;
	bh=UNrgkIa/dIuRpiNDWG7uYHRP7Uukwg6GyP9Ak+zGcOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l018uehWR6svIkslAMN+TheC1mmOTGkvaiQcZ6Ug917ZtJqNek7oOkA8g2gFVpCLOAd2gTMVqdSD/odddF7ayHNwvivbd077AB91EIXVyEpcpQy9ju9L2czxwjG+QKUO/Zq7AS4nV8Sqkj6JVKhE5sQrAOCEFsJPDe+hP5G77yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzHUwpXn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55ED3C4CECD;
	Sat,  7 Dec 2024 07:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733555898;
	bh=UNrgkIa/dIuRpiNDWG7uYHRP7Uukwg6GyP9Ak+zGcOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OzHUwpXnis03mzxxLj9cMjQobWrX6oE5VZALwG0BcjChyB2YV+TOg1lUv5POvvS1h
	 66y51pCVrAsGa7Felyl9wMpPRjxO4on17QpUjlggWwuMW9VLRBg9/ytMEXCiEag2J1
	 uEGtjkw9mSF7yD9mlaOMUNK0m1nojhmJEGDqRyIVCNLaSGFqqmvOIN77YtGq2ihwzi
	 1SIsfj6CizkTs+g52S5yFDML67ZHYOAPUnijJQMPmozI3huZea6dnO2i+owFyyppM+
	 qOD639UU3Xux1TodgtxoOgV7djxOHmteHhhfBt9AzgcbtliitV7DpwH884PRNZmaYG
	 ly8JpMkWq9vig==
Date: Sat, 7 Dec 2024 07:18:17 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Olaf Hering <olaf@aepfle.de>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v1] tools/hv: reduce resouce usage in hv_kvp_daemon
Message-ID: <Z1P2ucUPPEYN2cg5@liuwe-devbox-debian-v2>
References: <20241202123520.27812-1-olaf@aepfle.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202123520.27812-1-olaf@aepfle.de>

On Mon, Dec 02, 2024 at 01:35:16PM +0100, Olaf Hering wrote:
> hv_kvp_daemon uses popen(3) and system(3) as convinience helper to
> launch external helpers. These helpers are invoked via a
> temporary shell process. There is no need to keep this temporary
> process around while the helper runs. Replace this temporary shell
> with the actual helper process via 'exec'.
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>

Acked-by: Wei Liu <wei.liu@kernel.org>

