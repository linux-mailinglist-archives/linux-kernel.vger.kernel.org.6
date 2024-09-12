Return-Path: <linux-kernel+bounces-326717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86238976C1F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B88091C23ECE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5BE1AAE0A;
	Thu, 12 Sep 2024 14:30:23 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4C72837B
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726151422; cv=none; b=d+WU4kdmjNJAVMjhnSxNwpUkUWBqTRtM4esUHXk4ik+PxOnmlM4A4JUNiXagwiVSrLXi2sR0dgd3UPyF/UXKXTI36AG70wAwUA41/R5WtsSi4GzkFztBNxFEJgJ3Evi6euCwz5Lt4HVio3xrl1yyA0vOXo6rQq6kc//p48RgLhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726151422; c=relaxed/simple;
	bh=UC3lMubzbPDpKJQjNX8t1MIoec/d268RF96jy3oWT+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbDmolY+A952QMuaF67GkWdqShqDg6clTI1spfqI5gOdcKICcob/jHv19i8rIxMR4DBENIBSdB4wUT0cpW6h+x/wr3ltOygdEcoX64meiA4SV2gEJEG/+4UPe7nP5wl6ebCFyIszkORhwoGpZ4JHsA7AXwwGICsxTtHpCn1iR7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A390221B09;
	Thu, 12 Sep 2024 14:30:19 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8344113AD8;
	Thu, 12 Sep 2024 14:30:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Z+LBD/v64maDBQAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Thu, 12 Sep 2024 14:30:19 +0000
Date: Thu, 12 Sep 2024 16:29:13 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: kernel test robot <oliver.sang@intel.com>
Cc: Chao Yu <chao@kernel.org>, lkp@intel.com, linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, oe-lkp@lists.linux.dev,
	Jaegeuk Kim <jaegeuk@kernel.org>, ltp@lists.linux.it
Subject: Re: [LTP] [linus:master] [f2fs]  9f0f6bf427:  ltp.ADSP069.fail
Message-ID: <ZuL6uRAuIhAFTfJe@yuki.lan>
References: <202409122103.e45aa13b-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202409122103.e45aa13b-oliver.sang@intel.com>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: A390221B09
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

Hi!
So what the test does is:

- creates a sparse file (truncates an empty file to non-zero size)
- starts N child processes that open the file and read it in chunks
  while they expect zeros to be read
- starts a single writer child that opens the file with O_DIRECT
  and writes zeros to the file starting at some offset

And if the test fails it means that at some point one of the reader
children have seen inconsistent state.

-- 
Cyril Hrubis
chrubis@suse.cz

