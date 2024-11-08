Return-Path: <linux-kernel+bounces-401819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6EC9C1F9A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C842281489
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73AB1EBFEC;
	Fri,  8 Nov 2024 14:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="M6YlWERe"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E161C36;
	Fri,  8 Nov 2024 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731077264; cv=none; b=V+11bYisa3SxEqaUjDeLypmdAxaLeZDAGBO1WTR6Dzx6QSgY3hBdKSi44g/VTnhjvWglymO+Z+1qIK1kZz/CBWlP+3MwdcRQ4ls1McK5A02DdRXIi0srq+9CDYWIu6eiudlT4rH1vvv1iFqxMBHKm+RpDMzqpRFUPVVhOlv7wXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731077264; c=relaxed/simple;
	bh=psk2SXAMVFALWyaUCQ5Qwa0zmam/waSHXaep5VLw+yw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dfihIv7KJ95N22kudkK6QRb+2GmOBN1RhbVdzvAUj7fMMO2BJ+q+rMUv8Pd2VAZGB4qAByada/2tYEUvhIYnfcvLDquAf/pyeYUPaB2s45szszRf0EUKfVxkSZrX8RHGWQaHkDau/Oz8PqrXciM1mvrhDVdke6ePx5/YyLzvDtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=M6YlWERe; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3213B42C30
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1731077262; bh=rq9VOMz9/peUZMvh/KM8km5YSnndXAwqgCDSM2t1QC8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=M6YlWEResp29Gy7g1mPYewvyhdWA9qDHR++WtqKhkIIwRUkbhdXbjo5HFJBT4ZGfO
	 CODGhGqmigqah0eyWYqj2lNUfibGPbpmHkfxs+rSmlOJFiWaoALdZXtW6mBnmtTnSj
	 dH/xkp2BJfjJZjpz+5drjFSuUtNFaoGIlZILorJdm5TGoF3P/xhukStSEmmodVTjK6
	 A/PPnqDEoqemPN6QS1uocqDIPZnranyCAnFbQJapGOFI5KWKWQ2i+qRntc/Ta+3Cct
	 Pva5Wnw6qJOu23goVlNbC5SFAY+LrjBRk6D05itbUTYFOffPTTgTqWL5JBr57qjalO
	 6mpfJDXaljFBg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 3213B42C30;
	Fri,  8 Nov 2024 14:47:42 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: anish kumar <yesanishhere@gmail.com>, myungjoo.ham@samsung.com,
 cw00.choi@samsung.com
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: extcon: add documentation for Extcon
 subsystem
In-Reply-To: <CABCoZhANKY5wjc=NqAd64Fhmdjx1k-x=zVkU+ySRDRvK0Gj2iw@mail.gmail.com>
References: <20241103025436.69196-1-yesanishhere@gmail.com>
 <CABCoZhANKY5wjc=NqAd64Fhmdjx1k-x=zVkU+ySRDRvK0Gj2iw@mail.gmail.com>
Date: Fri, 08 Nov 2024 07:47:41 -0700
Message-ID: <871pzlzss2.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

anish kumar <yesanishhere@gmail.com> writes:

> Hello Myungjoo/Chanwoo,
>
> Wondering if you have any comments?

Anish: I'll say again: be more patient.  Never ping a maintainer in less
than a week's time.

I'll also add my voice to the chorus of people asking you to stop top
posting.

Thanks,

jon

