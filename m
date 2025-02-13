Return-Path: <linux-kernel+bounces-512322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AB7A33798
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 06:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3FB03A9963
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 05:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15688206F31;
	Thu, 13 Feb 2025 05:54:55 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA55204F85
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 05:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739426094; cv=none; b=DvASWo1CwOjRJKf6NA9IFF87teuZS94e1kuoO67t8DvbZia7SMDYxtFTiALipsBzadx65AXdCxXV5BvLAHETT0hQFLlaHtP3ROGcDBOgjkyDPYybikhtGWYo33ZTXnO8Fz4q9vJM7PaouWZnJxu/KtFlpaaIrCfNXIohKk28Agw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739426094; c=relaxed/simple;
	bh=9vSLec8ETTHERtaHFy4Xp9QgmnxKG422HkpMXjEIF64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dymMTKBOShYm9uj3U8rV7+hGXDuAoWcVX6Qaf63Yjg4P3MvSy2pt4ClIPxaRLDtMS8US61biHpwicdGlnKpol/B2YBU7Psctwh2fgx9ctvVXPbet8ckeMqKUXD+gFVtsPmsY8Vs8/fJar5b8W/SMwVhefszU0tSfjZvgJ5zGnFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id ABF4E67373; Thu, 13 Feb 2025 06:54:49 +0100 (CET)
Date: Thu, 13 Feb 2025 06:54:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Misc fixes on registering PCI NVMe CMB
Message-ID: <20250213055449.GB19370@lst.de>
References: <20250212170444.16138-1-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212170444.16138-1-uwu@icenowy.me>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Feb 13, 2025 at 01:04:42AM +0800, Icenowy Zheng wrote:
> Here is a small patchset that is developed during my investigation of
> a WARNING in my boot kernel log (AMD EPYC 7K62 CPU + Intel DC D4502
> SSD), which is because of the SSD's too-small CMB block (512KB only).

Hah, that's certainly and odd CMB configuration.


