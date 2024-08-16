Return-Path: <linux-kernel+bounces-290058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 364B7954EE7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E09292835D8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958591C3785;
	Fri, 16 Aug 2024 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nAcQpH9k"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74521C2331
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 16:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723825964; cv=none; b=YzLkf65BXWyPU+3TWcbt+Oe7J5tOTE3XZb6FUHDDZJ8OUx01U47Ek+J0bnv36Jej1iqVw96jo1mBc9tFmeQvUdmACmaFiTedn3H1M3uj/ZDkK9kqxdhwnFKPwGNSEJUg/RPu+aq5nRmXHXn/r3+3yrj+VEwkjHuIFpymjMU0HRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723825964; c=relaxed/simple;
	bh=3JVagcs2jM5qGqbmJ4FG7DknIaIuV8NTuH3u3H8kSog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cc8hej0r891E36cEHVv2V+gG1BMHl25qqcCZBX+/9BfQZIA+r7Pz5QNYuqYJM1QaLOsPOdxmDGBILu+HmL65gDjbaMQ77YsIcmHO+eBeWTiBujmT6Bti53tYVD93S+oGcm9FvWB5TdYEK63DUkJgl+A17itIfbTnEwiXJtG3GoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nAcQpH9k; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 16 Aug 2024 12:32:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723825960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3JVagcs2jM5qGqbmJ4FG7DknIaIuV8NTuH3u3H8kSog=;
	b=nAcQpH9kiaoXvhw3lTi5hhep0reI9jPG9HV/E4MIbxLj43rIyd+h7HrJEYDVj+d37jF3wF
	gvSsfDeTILKKYFy2Rv1HzEn6qIMd2h1/NUNOv5259eWHwhyRrAkdI4WZ9KUfS4hwPgkYE+
	cQyWx73uwuEyww5CGKytv8Tg/qUmJy4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+e3938cd6d761b78750e6@syzkaller.appspotmail.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] WARNING in __bch2_fsck_err
Message-ID: <yrxc3jbtwggttxi3eeq2fzt2jkvba26pmlhug6qq6l7b24q5zb@ynceeeea2a6p>
References: <000000000000df840a061fc9df08@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000df840a061fc9df08@google.com>
X-Migadu-Flow: FLOW_OUT

#syz fix: bcachefs: Fix forgetting to pass trans to fsck_err()

