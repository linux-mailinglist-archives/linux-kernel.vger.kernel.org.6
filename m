Return-Path: <linux-kernel+bounces-186141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 193188CC048
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1A081F21AA4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 11:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83E682897;
	Wed, 22 May 2024 11:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="BE1AGoj2"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3149781ACA
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 11:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716377425; cv=none; b=BGkcqgj4vswa1dX0uwVzpeP9RgQMkMav1S9qsZk+RkuYcKMVzD6U6KxsAGd0H3hq90Yps8jASPT2hxaVwK3axNln/O8c9sIv/5MSmjsESNepMVCcy7yi5g0Ky1dbOzCada6AgPwBTlxoY/j4pFkSyiW5cJAFYMv5rNDIKh5kD7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716377425; c=relaxed/simple;
	bh=jWpNIoMiRvnsFUlR4kKFILBDq4Nfl5l7tOREgN5i0MA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QIRCMcWKDxy3qSHiHk6/z874x8KX2EZmUSt/IQqebbxz9PyQQyhteQfnK2yNS3OcjkyS8JDdcNJfkKvvNMNt6i+vtaPkk1SkJewo0K3c+ya+lEsVTptBG91Rk9zQNZuT6RGgIny5pnKijKNQrWeSinA2B2rmjW8FCHBsO0J6O88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=BE1AGoj2; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc (unknown [10.10.165.15])
	by mail.ispras.ru (Postfix) with ESMTPSA id 4CBB14078501;
	Wed, 22 May 2024 11:30:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 4CBB14078501
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1716377413;
	bh=jWpNIoMiRvnsFUlR4kKFILBDq4Nfl5l7tOREgN5i0MA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BE1AGoj2w4bjqQi2JQNiJnQ2FwlI8h//o5kvO6qmjr68qe3k29cBh78ynf3G1tobo
	 G82P2gDC7sC5eQmjAw2L7kVOMRy85o7c1+w0OXUnLIfX5YKnOwGkoy90DXUn9ZuodN
	 cTH+zvfBw+oc/5WyegGDaVv5Hfpz3n9Zx7FuC9o4=
Date: Wed, 22 May 2024 14:30:06 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: syzbot+5205eb2f17de3e01946e@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in vmk80xx_write_packet/usb_submit_urb
Message-ID: <20240522-7737fa7827ec39328f23db8c-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000e617ad058d3eade5@google.com>

#syz dup: [syzbot] WARNING in vmk80xx_auto_attach/usb_submit_urb

