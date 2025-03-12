Return-Path: <linux-kernel+bounces-557152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5207A5D44C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 03:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07324178EBF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 02:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B571494C3;
	Wed, 12 Mar 2025 02:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antoniohickey.com header.i=@antoniohickey.com header.b="H5vMqAED";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="hrCHqPfu"
Received: from a48-105.smtp-out.amazonses.com (a48-105.smtp-out.amazonses.com [54.240.48.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A3013C9D4;
	Wed, 12 Mar 2025 02:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.48.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741745412; cv=none; b=VeLl9WHibhjviyGAwxX8mn17VZ4QF2MXHvO2hJVhPm29bGs2GheqeOb9XFGZ4DkHcOQLVRUB5K+FmNDIrJJlA8sHo5YRgJfXeGi1eOS/sJIEq1K9V/RvWznPh0VD0ez7Y5J19iBcnWaCkgyXMwK2GL+27n79Fo7cknE4kjGYGf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741745412; c=relaxed/simple;
	bh=MsogWZ4eW/JoOuF7a3G6IOjdj6EOE5vHYUBmx6Ennqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=csA20Fqp6Ld6oWKxX8DcTkZEzMXdmC53reyaM2/3UbuChw9iTnGOW/3TbReYNLuUEpc2JnmPodd1BlQBbzb1Z1oGoo69/iElARBBvxYmA6tjtINSWP9zqbHPgE68+wyozHJLBjfFk46r/D8NPgbGaD1kU7+2RFptnke2Knav1xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antoniohickey.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (2048-bit key) header.d=antoniohickey.com header.i=@antoniohickey.com header.b=H5vMqAED; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=hrCHqPfu; arc=none smtp.client-ip=54.240.48.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antoniohickey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=cgcwyxycg75iw36cao5ku2ksreqpjkvc; d=antoniohickey.com;
	t=1741745409;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MsogWZ4eW/JoOuF7a3G6IOjdj6EOE5vHYUBmx6Ennqw=;
	b=H5vMqAEDaBGHrvvITPrGCA2/GuInNRUGqwTeBVj9w+QKHDZvdHu7QELUY4BYikb8
	QXqazZR9rbjcBmByxJEwUoe1+NxV3NyqfGa31lNcApaR7lsy79rs5lMvY/QUNUkqchK
	CE90EDog0nwJCkRQV9u9Ni12sK8UtIVWXdjxyZvGxyqmFgzfteP6UwxLiGjCpGDlckc
	77iJGCjSQfgn0LRSFDwefI6a2hs8Sgg5cJTLPxviSXbiBi2ilF3kGQ4fsomYiv4T0Uf
	eCKkoGT0hNRdlCkWH+7GWEypgOq25PKgrmMA+xxWd103WeXKLNZkMPrYRIYTslxEsrL
	ZecL1xgG7A==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1741745409;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=MsogWZ4eW/JoOuF7a3G6IOjdj6EOE5vHYUBmx6Ennqw=;
	b=hrCHqPfubVwn2XzLKXNjN/TTeMl6zJyLVT0qkTuZjkI2FoEKW/orW6upZqpAYF6L
	qiYyUwO2QgnbQf/bM4vWAOaIvRteuSHOa/PGXXU12U26O++NJ9xxV/7BWmnC0WaI2xO
	F01Ha7FgqUUnXAYyjhpVWU2nmrGbHQhIPa/Hql4M=
From: Antonio Hickey <contact@antoniohickey.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, aliceryhl@google.com, 
	benno.lossin@proton.me, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, contact@antoniohickey.com, dakr@kernel.org, 
	gary@garyguo.net, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, morbo@google.com, 
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu
Subject: Re: [PATCH v2] rust: uaccess: mark UserSliceReader methods inline
Date: Wed, 12 Mar 2025 02:10:09 +0000
Message-ID: <01000195881dce87-c9f1ac46-3896-47f7-87de-84de94617a54-000000@email.amazonses.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <CANiq72mV=160jejuTO8jmsOszrkbXX0UAa1dvZ0VSyKaWcLqBg@mail.gmail.com>
References: <CANiq72mV=160jejuTO8jmsOszrkbXX0UAa1dvZ0VSyKaWcLqBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.us-east-1.3SHHfi5Rh4c+NdtIv+pxNWeqDT0J3zAhYZLMebdhE9o=:AmazonSES
X-SES-Outgoing: 2025.03.12-54.240.48.105

On Wed, Mar 12, 2025 at 02:56:26AM +0100, Miguel Ojeda wrote:
> The Suggested-by tag is meant to explain who suggested it, rather than
> duplicate the link -- please see:
> 
>     https://docs.kernel.org/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes
> 
> (I typically also put the Link after the tag, if the link is meant to
> show the original suggestion, just like the documentation requests for
> the Reported-by/Closes pair)
> 
> In any case, there is no need to re-send a v3 just for this, you can
> wait to see if there is any feedback.

Ahh ok yea the Suggested-by tag makes a lot more sense now haha had a feeling duplicating
the link wasn't right, but was more hesitant to mark someone in specific as suggested by.

Will make note of this for my future patches.

Thanks,
Antonio

