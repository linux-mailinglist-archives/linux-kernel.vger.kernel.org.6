Return-Path: <linux-kernel+bounces-434766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C209E6B08
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EDF416A8BC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C041EF097;
	Fri,  6 Dec 2024 09:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bit-ne.org header.i=@bit-ne.org header.b="vNwR3kQX"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6E118C932
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 09:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733478546; cv=none; b=BMe3a8U5tYcMWIeujMO4x8GDuHl2Ug5LIxxQeSgZfXMrCns4awg0BClxh3P2+MAEJTidUPIiBHiJyAZXGIZKT0Fxe+XxXK1vo1asGFcLDnnjDud98hiQANJWei4hlkQWt7yea+hbCPuLsplYjH6JSZt/tv9IOWCsMqW7upL7G5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733478546; c=relaxed/simple;
	bh=umuv83r3PTXRBVXQfRBXlKJirnNKIn1NdBYofzwxMN8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=CiQFpiU6TZrX66K6/79pAsilm9Noj92xjNSOgoA3sjpXQ1oINaulBmYIL0HlvCEriyVcss0egbiyf1GU62XQNvYDUNRM/HYMAUw6q6v5M6ZtpCghWufb9N6UX85jDqf1+CraGOJY7mRWzrRbFP+RahD9Sh5FurmYiU8ITb4uW98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-ne.org; spf=pass smtp.mailfrom=bit-ne.org; dkim=pass (2048-bit key) header.d=bit-ne.org header.i=@bit-ne.org header.b=vNwR3kQX; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-ne.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bit-ne.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bit-ne.org;
	s=ds202412; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IHHIBhTojn6IfKVkf7XR45a5eJjW+0DohyHzy6S5fvY=; b=vNwR3kQXq8FDYMYkhgGbGGiTTv
	z4pwxlbO0tfCn+4ZceXAsNW7gKE1w1zqDth2KnJYo013hwIJmOfzyiqlmKMz5trnOubprz1V9QoEX
	9VHaIiR3112loRcUQRD9Fy8dwvf7MKoGKmAbxfGHj+wHjEPAN0fGQJRQ5G/hdsCZRZq4kBSMmrMKn
	Ps7ySCYa5+XyiKAy1W0u72tpDnXRczFAYTmzVjtsryXYNTF1e4thbUm1m73ww6YO7mhgqUEN5tmtu
	k0EKm7IXMDIRiAdq8EF4XnrW0WCFMmH991ZQe9ioo9gL03vN+pVYRyRQJJt8vJ7S3JdefYKutZqAD
	9Ko8k+vA==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1tJUxE-007qYe-Gm
	for linux-kernel@vger.kernel.org;
	Fri, 06 Dec 2024 10:48:56 +0100
Message-ID: <df551d4f-96ce-4620-9c1c-6bde9242efd6@bit-ne.org>
Date: Fri, 6 Dec 2024 10:48:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <abbed@bit-ne.org>
Subject: Philosophy Updates (was Low Jitter, and related to Fair Pay)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

In arabic there is sectioning of the text, for instance prayer, has its 
own section.

This is now incorporated into my translation, using semicursive script, 
that supports this.

Language example, Ne is the only God (in semicursive).

Please also read more at: https://bit-ne.org/

Light,
Ywe Cærlyn
Abbed.

