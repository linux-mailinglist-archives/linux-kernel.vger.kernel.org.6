Return-Path: <linux-kernel+bounces-309455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A1B966AD9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 22:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4A011F234AE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C42A1BF7F3;
	Fri, 30 Aug 2024 20:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eBfjpKs0"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1729115C153;
	Fri, 30 Aug 2024 20:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725050980; cv=none; b=AGd5n4SSmiJjd0s5oQbEWfp0Jd+rGE/uvhE19lCj0mRNHWMYAhPTxYtVZX7h5dvFnL21/OWUfPq8JXq4lEyGAbulRPq+wVm0t1lTle599GbOYVbf8c+SqW9vL8hh8df+1F+bVYTkP56Qs97/IniJE7FGELupsx1vMR148yuGVVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725050980; c=relaxed/simple;
	bh=4SRyLoc+6Jnsm4lYr7P2VfriYExb1FzEmse6oBg0hwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vr9byOqhBALcWvnWsKl17Em8BZBrieomy6zWeAEDPqjewnpIClTlgk5xe57KpzhixJtE/6PZr2VNPeoeqNF/a8DUngtnE2tyYntg+/AkbgnaEsMqjILCDIKBUEd8nXPfruzFB1SPpRx7jGEqthskXengkbtsI3gY2yannGxUbRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eBfjpKs0; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725050977;
	bh=4SRyLoc+6Jnsm4lYr7P2VfriYExb1FzEmse6oBg0hwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eBfjpKs0awZ/lr4vBDJ9xv3h8mrfAL8VpaXBx+4a1qeciqYi65TzbprBmkMdft1Qb
	 8chxt/YgAiAdk7VgkqjFMdPdm7lIXOSOyraR46/00YGmHRQquDD6aChoqAwD+seXb6
	 DQBmgTBC6zHH8d7PqnCaJ49ffWJI+KTEml2xRIVw2OFgsWzTvOE2IYxKMsQKyJUrvu
	 wzWmU/vUbQ846O75hDVBAIT9BSYHeADgPCbmUanzMMdc0Nk+Cz4HUhJGKE/7Qb6HXl
	 0u8bbbkMrIoQaq7uVbJzx58YcX+DUDHTzV81mpJMfX8EpYrxR/p1YahlT94wQArfFk
	 KBmRAhs7jJgvQ==
Received: from notapiano (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4B61D17E1226;
	Fri, 30 Aug 2024 22:49:36 +0200 (CEST)
Date: Fri, 30 Aug 2024 16:49:34 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: mediatek: mt8195: Correct clock order for
 dp_intf*
Message-ID: <55fef13d-5eb5-4321-b506-1d8ae2d9f895@notapiano>
References: <20240802070951.1086616-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240802070951.1086616-1-wenst@chromium.org>

On Fri, Aug 02, 2024 at 03:09:50PM +0800, Chen-Yu Tsai wrote:
> The clocks for dp_intf* device nodes are given in the wrong order,
> causing the binding validation to fail.
> 
> Fixes: 6c2503b5856a ("arm64: dts: mt8195: Add dp-intf nodes")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas

