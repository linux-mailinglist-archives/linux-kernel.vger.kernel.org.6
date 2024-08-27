Return-Path: <linux-kernel+bounces-303102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A26DE96076A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D11E1F236F0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C1519D896;
	Tue, 27 Aug 2024 10:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s2bJASfJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D30517BEA1
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 10:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724754612; cv=none; b=PVayD0UGGwVPHuekDcMuNsBeYjNFYoSptBE0UtnpogbMk/SiPqmeZAGsMMhUYudtZGJCQ2LE9NRF8RFg0OHyZFlVeXOyR0whvmVLNubNa/Fl9hCPE3AOySJyyi1TxHjJ7jE+eeO3YCsc4MpmZ/r/b614pPj66j8As+lTmwSowyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724754612; c=relaxed/simple;
	bh=Ng/mowdnV8LcoLj1gKTCujeK9MbLzNrOnHTL1NSZZDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BboppzUg70rEt0Maq+O3ZDMpvTnV9dsvYHpCmEsIyWpEVNzO6F0VpOYspDZuuNOnMhVZC5dgNm7UPB3mlI8MFHrBBrn2h4hmK+pAhBioWmQHihIRO3L2DBOBziftTfwn97XljVqvTo7/SMKQ0VI+2yuIQtsCEUM9sh7g+Emo42k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s2bJASfJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE2DC8B7A0;
	Tue, 27 Aug 2024 10:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724754611;
	bh=Ng/mowdnV8LcoLj1gKTCujeK9MbLzNrOnHTL1NSZZDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s2bJASfJk6hagsFi0I9zP9j0osvLuZ4AAvwC4/Nnj1ZKEdFsTB7rW/dY30D5VRNG1
	 OCctFovBPX2I2ighXXqfu33zJkHZ+IuubcAogCxSVEBJ7uted/vG8+J8lOBavW+Cty
	 ryuf7z/B0B3w0/Qz/TsmkX7Ppz/t083KMlJtCyzY=
Date: Tue, 27 Aug 2024 12:30:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
Cc: kees@kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
	tianxianting.txt@alibaba-inc.com
Subject: Re: [PATCH] lkdtm: mark lkdtm_kprobe_handler for kprobe unavailable
Message-ID: <2024082753-reboot-rundown-850a@gregkh>
References: <20240827095235.12039-1-xianting.tian@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827095235.12039-1-xianting.tian@linux.alibaba.com>

On Tue, Aug 27, 2024 at 05:52:35PM +0800, Xianting Tian wrote:
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>

For obvious reasons we can't take patches without any changelog text.

thanks,

greg k-h

