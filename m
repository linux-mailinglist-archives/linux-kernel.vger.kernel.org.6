Return-Path: <linux-kernel+bounces-545091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0421A4E8F2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6044717E657
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C2727C865;
	Tue,  4 Mar 2025 17:01:44 +0000 (UTC)
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1194C2900B8
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107703; cv=fail; b=XhXtWzA+I8sIU+Lj9mxDQx57uPV0SrMajQRAI9xJAS39+4SRzw+ZLKULdXETKv/aY7IW2RCvMVmtcdEOqNbZa3tIG5nsrl4f8TIDq0LTKCc34oBXuKjeS2TtpfZjP8ccIyJDnYjFg/4NgIoFIDBw9DKSo957wyte+kL85Ta7STY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107703; c=relaxed/simple;
	bh=KeQ0VoGM6Dkcq4GFQF9kncgAovXB6KGYS7zrKUqrDSM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=et5a4CSCV4M1H+sWBTjluCXE11DGIYB7Do5+vJUF+ocIcEDRl15TdWHCvuYMLC03XF+cHLeOh+FS2HnMvjAIKATm2Sl4FtDx+J3oTts7TSj0uiynQl0jyujzuyfvv17jXxKqHyaKkraYzONF0DQCf2EMcVwmcuLyuPVmpj25+4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=cc.itu.edu.tr; arc=none smtp.client-ip=217.140.110.172; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=fail smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id 39E1140CECD0
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:01:40 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6f7k4QsWzFxgV
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:03:14 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 0B99E41898; Tue,  4 Mar 2025 18:03:00 +0300 (+03)
X-Envelope-From: <linux-kernel+bounces-541629-bozkiru=itu.edu.tr@vger.kernel.org>
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 4C65C42698
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:50:27 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw2.itu.edu.tr (Postfix) with SMTP id F1ACA2DCDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:50:26 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D2716756A
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C6B20D4E2;
	Mon,  3 Mar 2025 11:49:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B4420B7E6
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002543; cv=none; b=C8IQITl0o+OTyUgu9lG2Xn/L/H6AXBTj9HADReC46xOQnZgoyhxdAM+zIDgtMhXUqryiLMEBldwnUqBdd/5wartYktTn71HIzJI0I1UZNxhI4B2+HKullVhvB9AJZwYxcrYLTJC6k2A5H132FA3jcmhS0U9+qnJ/u8ipJ/a/2jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002543; c=relaxed/simple;
	bh=9s6g6Db4LACTEFBTUnj4MQyh/l8NCZzFTDha+qRJRhQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rc41IPzMQdMMwnbtA+jBuJl0cg1B9qAW5yc/T+o3bpKnKRbYoVPK+bxhLdfelY+ANcLxGgSIwQB1lN1XsPNhkxVrLIYvMUYjnCAApOj5/dK0DifJXrWRanwYHRS5FIGkPrK19k+czAf5XJ1r/kstXRsv2oLW9c+t61mjXux7MtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D6781063;
	Mon,  3 Mar 2025 03:49:13 -0800 (PST)
Received: from usa.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A6FC83F673;
	Mon,  3 Mar 2025 03:48:57 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Bill Mills <bill.mills@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_ffa: Set dma_mask for ffa devices
Date: Mon,  3 Mar 2025 11:48:45 +0000
Message-Id: <174100249569.1456.13505107409018325740.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <e3dd8042ac680bd74b6580c25df855d092079c18.1737107520.git.viresh.kumar@linaro.org>
References: <e3dd8042ac680bd74b6580c25df855d092079c18.1737107520.git.viresh.kumar@linaro.org>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6f7k4QsWzFxgV
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741712370.19118@S/VO84nzAFk6bN9cJtFXSQ
X-ITU-MailScanner-SpamCheck: not spam

On Fri, 17 Jan 2025 15:35:52 +0530, Viresh Kumar wrote:
> Set dma_mask for FFA devices, otherwise DMA allocation using the device=
 pointer
> lead to following warning:
>
> WARNING: CPU: 1 PID: 1 at kernel/dma/mapping.c:597 dma_alloc_attrs+0xe0=
/0x124
>
>
Applied to sudeep.holla/linux (for-next/ffa/updates), thanks!

[1/1] firmware: arm_ffa: Set dma_mask for ffa devices
      https://git.kernel.org/sudeep.holla/c/cc0aac7ca17e
--
Regards,
Sudeep



