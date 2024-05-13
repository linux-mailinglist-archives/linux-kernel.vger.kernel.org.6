Return-Path: <linux-kernel+bounces-177707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E97678C4379
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A0F7285E88
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 14:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2699046BF;
	Mon, 13 May 2024 14:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="dvVTHdBj"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C7523BE
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 14:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715611709; cv=none; b=e9TvZFW9/xLURyE/tczM20xIIM7wI7WwiKMtPX5LPrtSnbzSwaVuSvkw+UeGJXOZsTlL8Kv5bR8arMtG7Ihkj8Sbb+y5AzYCPa/XIICmfaIJp8iWmRPxeZsZpHAboLRJuzS9GrWdkU+JGzi6Oqqxvx9n4cUNzsdArvb39WjZreg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715611709; c=relaxed/simple;
	bh=y4efa16kLFpbbZ8XWKQB3BfTcf+62U18pINNyU9G4jU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=imR/2y1W2kAeMahEkQM3J3ramgN/vtpQwV8+fj8M7JnDvF+EbmomxseZW9O8c126YtNzUlhmkg9MrUa31fMmhSZA2GxGtD8oA1W2TcatX78Pnwq/JDNCMtqboFwk7UumrEZvmct7f/EERnIpaSj2rwrulRBAxd0UtcACjdvWcmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=dvVTHdBj; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1715611704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7omKN+Pfe4q92+T26TXlvGrIMir00MoHuNeD4JbUVOo=;
	b=dvVTHdBjLyLstIW04xOXCQuzu4rVe0WxBXcasjD+mkZiHHu9Fh/iUHh0kLMeBgR2hZFYsp
	7EyudhKiPfBv6PoehATJ8aXJ1yuY0OmR6Wr5+5MP+d8KJzH5FBPefJGepjXZyIhlXe4MnX
	Tc8YPj3lGrNMbqhefkTp7u0SBAEfMVMHZ+MpDxi6YVqD+E66AhQZf9iMLWUihKtnMTOWKD
	G9Kkxvf9TC+1NixCf9Ga2pdEQHLWkF39lWNKXuAr28dekjGxa0OAhK+lzichLWdyY+cGZz
	jYnBtbrsjd027sLW1SyeUJ9brXZa+cJmFFMJ53yUkGYnFICI6bMfOocc/iDxjA==
From: Diederik de Haas <didi.debian@cknow.org>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>, Joe Perches <joe@perches.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] docs: dev-tools: checkpatch: Add targets for checkpatch tags
Date: Mon, 13 May 2024 16:48:13 +0200
Message-ID: <32373229.FC8mGFU5Tv@bagend>
Organization: Connecting Knowledge
In-Reply-To:
 <CAKXUXMzw6_JnPxXfgU2tEU-VkU6E_=ee-V4MUzGX8MQCSXLuNA@mail.gmail.com>
References:
 <20240513102237.112376-1-didi.debian@cknow.org> <87a5kuez97.fsf@intel.com>
 <CAKXUXMzw6_JnPxXfgU2tEU-VkU6E_=ee-V4MUzGX8MQCSXLuNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5799183.NjtpuSdjI8";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Migadu-Flow: FLOW_OUT

--nextPart5799183.NjtpuSdjI8
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
Date: Mon, 13 May 2024 16:48:13 +0200
Message-ID: <32373229.FC8mGFU5Tv@bagend>
Organization: Connecting Knowledge
MIME-Version: 1.0

On Monday, 13 May 2024 13:46:39 CEST Lukas Bulwahn wrote:
> It is important to check that the verbose option of
> the checkpatch still works. The script actually parses the
> documentation and then shows the relevant parts as verbose output to
> the user.

I wasn't aware of that functionality as I've mostly used ``--terse``.
What I want(ed) is having the documentation for a tag easily accessible.
But it doesn't get much better then it already being part of the tool.

IOW: Please disregard this patch.

Cheers,
  Diederik
--nextPart5799183.NjtpuSdjI8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZkIoLQAKCRDXblvOeH7b
btrPAQCIhM6b6gZllypG+wwdG77jh6I9HILVzviHH+fan4Vz5QEAi2QSXgujMBLz
VDRGnyHlTFt/bAIfAdIVRuYRadwkHwA=
=l8Kc
-----END PGP SIGNATURE-----

--nextPart5799183.NjtpuSdjI8--




