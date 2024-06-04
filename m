Return-Path: <linux-kernel+bounces-201278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E33408FBC73
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EF86B25C09
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E71814AD36;
	Tue,  4 Jun 2024 19:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Ba5ZIYTy"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E66A801;
	Tue,  4 Jun 2024 19:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717528854; cv=none; b=aszBDxTXjL3qqfrvT7LI3IKXRyQWeX63pcbmZWFcC1P6yXbCYNo75UgP9LrEIPpQ1WqBfihmH7CFj8gkhPEmuLw/U4/eSIOQ5DKLHuwCK9jz1dxtw8oWuAfuuYr3u2V/nkaj6mtjZQ98Yx3p78TQWQjvj0pI0hBgjKAPCkex4Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717528854; c=relaxed/simple;
	bh=iEIJ1ODrXLu8gKKalSPXoQUGalwH+oelgUDRq8s7R8A=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=o3+3p95wia/C7gfBDwGIu6MODH1i/y1/DsasUqdCUukU/TBvUweUD7/4+D2/GfrRBeqmVnE0jIPvoODE+TWAka1JzUcZZyIVST9HGdcNjisR43MT/ci+qset4/qM3nfRo3xEZCFXhjslJMAwJNqktl9ro+InDx0StudNTsWu7fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Ba5ZIYTy; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1717528850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=db/Sl9j482azBoAdhWtuIMKD0VB/oszgMwHPRWC6tXQ=;
	b=Ba5ZIYTySI0OuLOX2S8DKaSXYQyd9j7j3JkCIjtrrWomudObV6fdgaMIVW/Ns9dK+vDT7b
	IKCV09hJ1biUgpqpNTVRzilYMdTv5exJkRMPy3EC2SfxsQRFPSZgPhyLeYJ9psFPkg8eh8
	46FtGa+a4vrRYq8AFVi1Q2um/uVQGKkSy9kLziYw+RMOD8zVJb85fZM1sb5KJThJoTmkV4
	uPv5okFYbxu7f+Tozmna+NzaOZwz5xpmKzQCAXIJihfPNZrt1hyKIs6zVAFEoOFgnzV9el
	e17uEA/bczRWhCZifAiIlo671TRGXWpJJdHLebQsxct8qrb3wBDzlQxB2p4yiA==
Date: Tue, 04 Jun 2024 21:20:49 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, Srinivas Kandagatla
 <srinivas.kandagatla@linaro.org>, Banajit Goswami <bgoswami@quicinc.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, kernel@quicinc.com
Subject: Re: [PATCH] ASoC: qcom: add missing MODULE_DESCRIPTION() macro
In-Reply-To: <0bd0a518-4d85-4251-9bf9-d056dc3d7b08@sirena.org.uk>
References: <20240603-md-snd-soc-qcom-sdw-v1-1-101ea8bcdd38@quicinc.com>
 <0bd0a518-4d85-4251-9bf9-d056dc3d7b08@sirena.org.uk>
Message-ID: <04bfcdd0088f521e4418a77e528652e3@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-06-04 13:56, Mark Brown wrote:
> On Mon, Jun 03, 2024 at 05:16:07PM -0700, Jeff Johnson wrote:
>> make allmodconfig && make W=1 C=1 reports:
>> WARNING: modpost: missing MODULE_DESCRIPTION() in 
>> sound/soc/qcom/snd-soc-qcom-sdw.o
> 
> Is anyone getting any value from these MODULE_DESCRIPTION()s?  This all
> just seems like a huge amount of noise and I'm having trouble thinking
> of a use case.

FWIW, I find module descriptions useful.  Of course, there are
some of them that don't provide much value, but the well-written
ones are good.

