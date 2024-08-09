Return-Path: <linux-kernel+bounces-280675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0822C94CD8D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39EDD1C21BE5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED12193086;
	Fri,  9 Aug 2024 09:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="ZyRFsPsw"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42860191F80
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 09:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196771; cv=none; b=NKKiE6ABVu20mcAYSbUijzsdC0Ppcd+KzVaIGXkYWQF1MmYvFUHBN2m2j5oz0eAlNJgygdp46yGMKg3UO8nQ1dtgE4ObIbiNL+Mq4Lq23LalIP8vynY/cwV6RJkr42SNOwcTVXNrJHEPa0Y7gdlISi3TS0f3QDyC7X2RtuX2P98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196771; c=relaxed/simple;
	bh=zETfSsyODy+KOzZINhW9CnH4MBAVbSRsn7M5jrCuN9M=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=X0hHTk1vof8nHHemhLTy9SQ9IvUZ5PILLpn9h8peC26G3QbngS3luVOsvRkB8qa58frDohPFhxGmbSUslkyqsAZgMI4xo1X+x3eiirNJRddt7iuOsAeNoB6IRbfPIzaTz2rnHrrFj7y/1iG0rr6FtgIDzz6S0KwFK+HAaRslcsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=ZyRFsPsw; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.20] (p5de45112.dip0.t-ipconnect.de [93.228.81.18])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id EFEDE2FC004D;
	Fri,  9 Aug 2024 11:37:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1723196241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zETfSsyODy+KOzZINhW9CnH4MBAVbSRsn7M5jrCuN9M=;
	b=ZyRFsPsw00dV0zfQJf++hJRnSY6R+CQghMZ4SNRfg+VEwLA7YFu4rcROjRpTuUmgbJpufM
	sT3SvvhHEHZU+G2KptBI/jaVZWsQ2/w57Ifhh2snfnCcvJNxix6UP1QEg/J0+quAuKdphV
	VdsTzlkiINRTkbTl79AD87sD8Qi44DQ=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <fea10570-7832-428f-a44d-a2de41893c69@tuxedocomputers.com>
Date: Fri, 9 Aug 2024 11:37:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: g.gottleuber@tuxedocomputers.com
Cc: axboe@kernel.dk, ggo@tuxedocomputers.com, hch@lst.de, kbusch@kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, wse@tuxedocomputers.com
References: <f7a70add-4d65-40a4-91ff-70bc14a64467@tuxedocomputers.com>
Subject: Re: [PATCH] nvme-pci: Add sleep quirk for Samsung 990 Evo
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <f7a70add-4d65-40a4-91ff-70bc14a64467@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

(hope Thunderbird supports In-Reply-To via mailto links)

wanted to give this thread a gentle push

Kind regards,

Werner


