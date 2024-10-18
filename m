Return-Path: <linux-kernel+bounces-372527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7357D9A49D0
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 01:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35C85283601
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 23:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC2F190075;
	Fri, 18 Oct 2024 23:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="X5G5eSAp"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D664D188010;
	Fri, 18 Oct 2024 23:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293047; cv=none; b=hNs8BSq3/qJA3Aqc6mI0n/p0K20ZYVMCDvPH7SclbxgHRs4QgK0ZrI0SCmVPuL/1Lbmx5zv20Lfi5mGmz/aRJfnm7dU/+nNETVT/miKIdBJjLAtwiD2FBQmsqHN7hQyBXxarnmaY8T/Lz5sD1+P0KS+V7fANfOQpmlRoS/HrwEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293047; c=relaxed/simple;
	bh=otoe+BGRbyuDn/lOepWOrtR+flmjPhfhb96L2mqFw0g=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m55G6s6BNwO8emyMhpgvgoFrLTSdI2pq0FTjH1WzYL2SP0CoyoTrjGg+t2DukQgShGUzW0PLtM0kB9DrpuImeK5GVS5hfCUZR+HFB8WxOL2BjuTicy6Z37CdCmS5CFjFxhpPxszlSSD0rxJe6bwILdhVnlFeQ4t/pej8twdLclk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=X5G5eSAp; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1807A42C06
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1729293039; bh=5AWQDmmLs2C5s9TCiUZ+fDHV3xfKrluqYeFPnJ++8vA=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=X5G5eSAp6EeGcJqehcoRZE3PL3L31iaFSgUYiXvVsetIXEoFpcVvmmPcaKh1RrxIP
	 fkol8pSTy/cQla19vSx1qzAfuHQzaqHcJSePvtD2PSkkZyplzZUvCC3nR3QVrQ0f/E
	 j7ssQyjwjApqE/Q0brJ0eLcLdpn0o+VBMdhC7K0XrlNFqrUu+zgFQUYdNAuid4OHc4
	 hCezvs7qFgeuTIlBr4vmEHFDl8ruyu6mz8UQS1hNOE3FM+4Z5wckowQ7U6u7NmZDOE
	 SZlTooQLmvdX5icTCCEsrfIILEVKnBH2XpXjJhyo/3BC5OD8JF7ovasLk324IOd11d
	 BqNX1PVvANyOw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625:67c:16ff:fe81:5f9b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 1807A42C06;
	Fri, 18 Oct 2024 23:10:39 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Nir Lichtman <nir@lichtman.org>, jason.wessel@windriver.com,
 daniel.thompson@linaro.org, dianders@chromium.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Documentation: English fixes in kgdb/kdb article
In-Reply-To: <20241018223536.GA799515@lichtman.org>
References: <20241018163136.GA795979@lichtman.org>
 <20241018175540.GA796909@lichtman.org>
 <20241018223536.GA799515@lichtman.org>
Date: Fri, 18 Oct 2024 17:10:38 -0600
Message-ID: <87wmi5vwgh.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

A couple of comments..

Nir Lichtman <nir@lichtman.org> writes:

> Minor grammar and typos fixed in the kgdb/kdb article
>
> Signed-off-by: Nir Lichtman <nir@lichtman.org>
> ---

When you post followup versions to a patch, please put an explanation in
this space saying what has changed; that makes life easier for
reviewers. 

>  Documentation/dev-tools/kgdb.rst | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)

Beyond that, it is good to wait a little while before posting new
versions to let other reviews come through.  Three iterations in one day
are a bit much.

That said, the patch looks OK now; I'll apply it shortly.

Thanks,

jon

