Return-Path: <linux-kernel+bounces-262768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C855193CC74
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 03:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 447B8B2102F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 01:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D95017E9;
	Fri, 26 Jul 2024 01:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qeyinge.ooguy.com header.i=info@qeyinge.ooguy.com header.b="IMwRU2ad"
Received: from mail0.qeyinge.ooguy.com (unknown [79.141.160.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCDF36D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 01:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.141.160.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721957675; cv=none; b=O2Ji+F3uSCM4ORTTUCNKhYBjJLlr93hINQiGF+NfQNngK2zNCLl2F9rprWbmSNmz6fFOO2xGatnMpGtHTuS/zG7OiFSb4H27uJ0gX1Um85qCwzYjuTBjg3hKtAJkjrg7mYbz5i2IS49JmPmFP1Mv3kancNXsKBsr/9OVb089w2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721957675; c=relaxed/simple;
	bh=uppjbLTslEyKr6ZAJxe/hkq8tn5x938SCJetuIqxMhc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IDWeM+/1EGtWEuIvIm/wlbj21YwqEPYJl1AOGmavwt1L4YqgQKIDrQ/HdDyrkUE/EtXFfyUV7W44alF5dp832XeZmXTWl3HKru2dgGWJDI0dfAaLjd/prrPPS1Qoa5Y4bYCbWcIwsWoCSm/yp8p2xqGWX0JdvbQS6QxrlH2cp8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=qeyinge.ooguy.com; spf=pass smtp.mailfrom=qeyinge.ooguy.com; dkim=pass (1024-bit key) header.d=qeyinge.ooguy.com header.i=info@qeyinge.ooguy.com header.b=IMwRU2ad; arc=none smtp.client-ip=79.141.160.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=qeyinge.ooguy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qeyinge.ooguy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=default; d=qeyinge.ooguy.com;
 h=Reply-To:From:To:Subject:Date:Message-ID:MIME-Version:List-Unsubscribe:
 Content-Type:Content-Transfer-Encoding; i=info@qeyinge.ooguy.com;
 bh=uppjbLTslEyKr6ZAJxe/hkq8tn5x938SCJetuIqxMhc=;
 b=IMwRU2adtwjbrgpFi+o8Y7S4Ss9DrhSXeslX7jcmgpsYi5vdg+EVAwymJtO3miugN2sADMU4R3ZW
   rIQQgOBZRsnJrJcUKGhze8U4DJ1+TlY1XIJojR3IROsWSua8dLqL+m7pz+ZzOx15OFbiXiLXEbtz
   Cd9vfQNW035aw+m6iRY=
Reply-To: dmerkur@thomson-rogers.com
From: TR LAW<info@qeyinge.ooguy.com>
To: linux-kernel@vger.kernel.org
Subject: Good Day
Date: 26 Jul 2024 03:24:24 +0200
Message-ID: <20240726032424.23BD1C386AEDA6C6@qeyinge.ooguy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Good Day,

I sent you an email earlier of a business proposal. Did you=20
receive it or should I resend it


Darcy R. Merkur

Partner

Email: dmerku@thomson-rogers.com









 Unsubscribe=20

