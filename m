Return-Path: <linux-kernel+bounces-285457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D92BC950DB2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B66E28204F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 20:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1E51A4F3A;
	Tue, 13 Aug 2024 20:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=b-i-t.uno header.i=@b-i-t.uno header.b="XhEZ5tNj"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3328AA953
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 20:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723580099; cv=none; b=kuj5gIa/7Yh3sH6L7+DHK5lcAfDpmRSEqrYk+wiUws55d5BFKefHqUt0vegTs10hCKTZTINLvu1z05KDLuRKGZ68F5ta4l7qXPl9MEjd8g+fxngm0FV2vQ6RP9R5/uVS1APWtVJzvdg7IkPTXwRdC7HIN7JxUt6eZEm3Zv1TAxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723580099; c=relaxed/simple;
	bh=ZiN7VOexTFynB+Rs/7kikULrgYpGZgxMI/B2UGRmXmw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=HxjCfXIyVHfumSoa4qBVr4NA7WvpInzhNgXWOhBCdo4b9bEqlOwN/c8a1+dNMQFD3kdK553F3v8kyjqYfvACUDER8UMGyha9SMRz4eu/CNtrYL1dCEI/NXsIoaBAUSRuGjdPFRZmkFf6XSSsbzc9tP0/eXRL84Y4OKkBfBngIbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b-i-t.uno; spf=pass smtp.mailfrom=b-i-t.uno; dkim=pass (2048-bit key) header.d=b-i-t.uno header.i=@b-i-t.uno header.b=XhEZ5tNj; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b-i-t.uno
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=b-i-t.uno
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=b-i-t.uno;
	s=ds202310; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fcoZnbbwvrQdJNPljlnd2tjXXEtuvYtmliQjqZMCHVw=; b=XhEZ5tNjTw69AD7VwHAAxFgStu
	FcTmYkYicImy6BX4O992E1Jsk4lQVkdwg1EdsNiPHbiYRkk1KqRXUVXNdoEPNSm5dRVXHNL8lVEqD
	s47QWtF8bfPjzPz4Tlzv/T+P1YOl4EYjdAByPGwmGMJF3BnLnHaQXVX9rxP1e0sLgLqlKCiVQcEKu
	GbqHSpGLHH2bSQ4uvz4j5ccmvhrOwKKwz5gYpU2ovInclEyhiL5PYjmcbGlEtTlQGMgX4XApfRjQX
	a0U2/w+zM6gSiWHMPkyK5s9If/bnn9h9sM+idh9SrQNv22C60yYSNQe5qdNZh6U5RuzDkkOb6kvVi
	8zqJiRKg==;
Received: from [2a02:fe1:716d:5f00:4d51:3a2c:b935:8dc9] (port=57649)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ycar@b-i-t.uno>)
	id 1sdxuq-008uYE-Ji
	for linux-kernel@vger.kernel.org;
	Tue, 13 Aug 2024 22:14:48 +0200
Message-ID: <867da088-11c1-4e9b-962a-22295951afa8@b-i-t.uno>
Date: Tue, 13 Aug 2024 22:14:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <Ycar@b-i-t.uno>
Subject: Fair Pay Philosophy, Low Jitter project now on own domain
 https://b-i-t.uno/
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Greetings.

The fair pay philosophy and low jitter project is now on its own domain: 
https://b-i-t.uno/

I did the mascot project B i t in the 90x (still sometimes release some 
music on that) popularizing Open Code and testing the philosophical 
principles, that now is presented here: https://b-i-t.uno/

Everybody wants their share here, unto Kings if will be, and you should 
definately check it out.

Main Point: Everything can be designed according to IT, which can be 
considered The Initiator, a name of the theo, often of IT Philes.

So be happy putting togheter IT x.

Light.
Ywe Cærlyn
Ruhban.




